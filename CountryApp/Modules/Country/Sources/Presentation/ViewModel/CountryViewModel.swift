//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation
import Dependencies
import Combine

// View state for determininstic view rendering.
public enum ViewState {
    case loading
    case loaded(countries: [CountryEntity])
    case error(error: Error)
}

// Data Flow (flow outwards)
//      Presnetation (Viewmodel -> Usecase)
// Dependency
//      Domain <- Presentation

@MainActor // Will dispatch all the calls to the View in the main thread.
public class CountryViewModel: ObservableObject {
    
    @Dependency(\.userCaseCountry) private var userCaseCountry
    
    @Published var viewState: ViewState = .loading
    let subject = PassthroughSubject<ViewState, Never>()
    
    private var allCountries: [CountryEntity] = []
    
    public init() {
        
    }
    
    public func fetchCountries() async {
        viewState = .loading
        subject.send(.loading)
        do {
            let countries = try await userCaseCountry.execute()
            viewState = .loaded(countries: countries)
            subject.send(.loaded(countries: countries))
            allCountries = countries
        } catch {
            viewState = .error(error: error)
        }
    }
    
    public func filterCountries(with filterTerm: String) async {
        let term = filterTerm.lowercased().replacingOccurrences(of: " ", with: "")
        if term.isEmpty { // if the search term is empty, then reset the viewState with the full list
            viewState = .loaded(countries: allCountries)
            subject.send(.loaded(countries: allCountries))
        } else {
            let countries = allCountries.filter {
                $0.name.lowercased().contains(term) ||
                $0.capital.lowercased().contains(term)
            }
            viewState = .loaded(countries: countries)
            subject.send(.loaded(countries: countries))
        }
    }
}
