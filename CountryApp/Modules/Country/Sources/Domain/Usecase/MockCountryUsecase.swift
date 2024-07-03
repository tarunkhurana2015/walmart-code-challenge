//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/22/24.
//

import Foundation

import Foundation
import Dependencies

public struct MockCountryUsecaseImpl: CountryUsecase {
    
    public var shouldSucceed: Bool = false
    public var shouldBeEmpty: Bool = false
    public var shouldBeError: Bool = false
    
    public func execute() async throws -> [CountryEntity] {
        if shouldSucceed {
            if let countries = await JSONReader().loadJson(filename: "Country") {
                return countries
            } else {
                throw CountryError.jsonDeocdingError
            }
        }
        if shouldBeEmpty {
            return []
        }
        if shouldBeError {
            throw CountryError.noDataFound
        }
        throw CountryError.unknown
    }
}
