//
//  Bundle_Decodable.swift
//  MoonshotApp
//
//  Created by Kiran Sonne on 23/11/22.
//

import Foundation
extension Bundle {
    func decode<T: Codable>(_ file: String) ->  T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("failed to locate \(file) in bundles.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("failed to decode \(file) from bundle.")
         }
        
        return loaded
    }
}
