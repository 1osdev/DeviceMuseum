//
//  DataManager.swift
//  DeviceMuseum
//
//  Created by Дмитрий Смирнов on 3.05.22.
//

import Foundation

let deviceData:[Device] = load("devices.json")

// Load data from JSON file
func load<T:Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
    let data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
        fatalError("Not possible to find \(filename) in main app")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Not possible to find \(filename) from main app \n\(error)")
    }
    
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Not possible to parsing \(filename) as \(T.self) - \n\(error)")
        }
    }
