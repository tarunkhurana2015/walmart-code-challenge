//
//  File.swift
//  
//
//  Created by Tarun Khurana on 5/22/24.
//

import Foundation

struct JSONReader {
    func loadJson(filename fileName: String) async -> [CountryEntity]? {
        if let url = Bundle.module.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([CountryEntity].self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
