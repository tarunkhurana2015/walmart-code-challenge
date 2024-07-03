//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/20/24.
//

import Foundation

protocol URLFactoryProtocol {
    func makeURL() async -> URL?
}

struct CountryURLFactory: URLFactoryProtocol {
    public func makeURL() async -> URL? {
        return URL(string: CountryAPI.baseURL + CountryAPI.basePath)
    }
}
