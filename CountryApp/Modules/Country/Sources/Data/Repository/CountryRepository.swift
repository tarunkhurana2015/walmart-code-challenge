//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation
import Dependencies
import Network

// Data Flow (flow outwards)
//      Data (Repository -> Network)
// Dependency (Inversion)
//      Data -> Domain
struct CountryRepository: CountryRepositoryProtocol {
    
    @Dependency(\.networkURLSession) private var networkURLSession
    
    func getCountries() async throws -> [CountryEntity] {        
        do {
            guard let url = await CountryURLFactory().makeURL() else {
                throw CountryError.urlNotFound
            }
            let request = URLRequest(url: url)
            let data = try await networkURLSession.request(request)
            let countryData: [CountryRemoteModel] = try await CountryDecoderFactory().decodeCountry(data: data)
            return countryData.map { CountryEntity(name: $0.name, region: $0.region, code: $0.code, capital: $0.capital, flag: $0.flag) }
        } catch {
            throw error
        }
    }
}
