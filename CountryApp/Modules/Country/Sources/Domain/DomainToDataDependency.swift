//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation
import Dependencies

enum CountryRepositoryKey: DependencyKey {
    static var liveValue: CountryRepositoryProtocol = CountryRepository()
}

extension DependencyValues {
    public var repositoryCountry: CountryRepositoryProtocol {
        get { self[CountryRepositoryKey.self] }
        set { self[CountryRepositoryKey.self] = newValue } 
    }
}

