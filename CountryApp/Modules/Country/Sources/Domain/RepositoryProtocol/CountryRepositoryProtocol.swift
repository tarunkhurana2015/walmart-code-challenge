//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation

public protocol CountryRepositoryProtocol {
    func getCountries() async throws -> [CountryEntity]
}
