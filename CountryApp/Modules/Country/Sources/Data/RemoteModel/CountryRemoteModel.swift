//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

/// CountryRemoteModel - This is a direct mapping model with the api response.
import Foundation
struct CountryRemoteModel: Decodable {
    let capital: String
    let code: String
    let currency: CommonRemoteModel
    let flag: String
    let language: CommonRemoteModel
    let name: String
    let region: String
}
struct CommonRemoteModel: Decodable {
    let code: String
    let name: String
    let symbol: String?
    
    enum CodingKeys: String, CodingKey {
        case code
        case name
        case symbol
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = (try? values.decode(String.self, forKey: .code)) ?? ""
        name = try values.decode(String.self, forKey: .name)
        symbol = (try? values.decode(String.self, forKey: .symbol)) ?? nil
    }
}
