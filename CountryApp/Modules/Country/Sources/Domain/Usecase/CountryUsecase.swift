//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation
import Dependencies

// Data Flow (flow outwards)
//      Domain (Usecase -> Repository)
// Dependency
//      Data -> Domain (Usecase) <- Presentation
public protocol CountryUsecase {
    func execute() async throws -> [CountryEntity]
}

public struct CountryUsecaseImpl: CountryUsecase {
    
    @Dependency(\.repositoryCountry) private var repositoryCountry
    
    public func execute() async throws -> [CountryEntity] {
        do {
            return try await repositoryCountry.getCountries()
        } catch {
            throw error
        }
    }
}
