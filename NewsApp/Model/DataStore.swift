//
//  DataStore.swift
//  NewsApp
//
//  Created by Rohit Saini on 10/07/21.
//

import Foundation

protocol DataStore:Actor{
    associatedtype D
    
    func save(_ current: D)
    func load() -> D?
}

actor PlistDataStore<T:Codable>:DataStore where T: Equatable{
    
    var saved: T?
    let filename: String
    
    
    init(filename: String){
        self.filename = filename
    }
    
    private var dataURL: URL{
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(filename)")
    }
    func save(_ current: T) {
        if let saved = self.saved, saved == current{
            return
        }
        do{
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .binary
            let data = try encoder.encode(current)
            try data.write(to: dataURL, options:[.atomic])
            self.saved = current
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    func load() -> T? {
        do{
            let data = try Data(contentsOf: dataURL)
            let decoder = PropertyListDecoder()
            let current = try decoder.decode(T.self, from: data)
            self.saved = current
            return current
        }
        catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    
}
