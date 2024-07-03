//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation

protocol CountryDecoderFactoryProtocol {
    func decodeCountry<T: Decodable>(data: Data) async throws -> [T]
}

struct CountryDecoderFactory: CountryDecoderFactoryProtocol {
    public func decodeCountry<T: Decodable>(data: Data) async throws -> [T] {
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            throw CountryError.jsonDeocdingError
        }
    }
}
