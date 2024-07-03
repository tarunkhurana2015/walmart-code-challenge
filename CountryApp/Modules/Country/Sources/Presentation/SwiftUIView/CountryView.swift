//
//  SwiftUIView.swift
//  
//
//  Created by Tarun Khurana on 6/10/24.
//

import SwiftUI

public struct CountryView: View {
    
    @ObservedObject var viewModel: CountryViewModel
    
    @State var searchTerm: String = ""
    
    public init(viewModel: CountryViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            switch viewModel.viewState {
            case .loading:
                Text("Loading...")
            case let .loaded(countries):
                NavigationStack {
                    VStack {
                        if countries.count == 0 {
                            VStack {
                                Spacer()
                                Text("No county found with name or capital")
                                Text(searchTerm)
                                    .foregroundColor(.red)
                                Spacer()
                            }
                        }
                        List(countries, id: \.code) { country in
                            NavigationLink(value: country) {
                                CountryItemView(countryEntity: country)
                            }
                        }.navigationDestination(for: CountryEntity.self) { entity in
                            CountryDetailView(countryEntity: entity)                                
                        }
                    }.navigationTitle("Search")
                }.searchable(text: $searchTerm, prompt: "Search for Country")
                    .onChange(of: searchTerm, perform: { value in
                        Task {
                            await viewModel.filterCountries(with: value)
                        }
                    })
                    
            case let .error(error):
                Text("Error loading data - \(error.localizedDescription)")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCountries()
            }
        }
        
    }
}

#Preview {
    CountryView(viewModel: CountryViewModel())
}
