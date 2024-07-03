//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation
import Dependencies

enum CountryUsecaseKey: DependencyKey {
    static var liveValue: CountryUsecase = CountryUsecaseImpl()
}

extension DependencyValues {
    var userCaseCountry: CountryUsecase {
        get { self[CountryUsecaseKey.self] }
        set { self[CountryUsecaseKey.self] = newValue }
    }
}
