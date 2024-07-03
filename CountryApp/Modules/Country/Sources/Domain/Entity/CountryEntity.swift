//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation

public struct CountryEntity: Decodable, Hashable {
    let name: String
    let region: String
    let code: String
    let capital: String
    let flag: String
}
