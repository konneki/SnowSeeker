//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Daniel Konnek on 8.03.2023.
//

import Foundation

class Favourites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favourites"
    
    init() {
        //let userDefaultsData = UserDefaults.standard.array(forKey: saveKey)
        //print(userDefaultsData ?? [])
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        //UserDefaults.standard.set(Array(resorts), forKey: saveKey)
    }
}
