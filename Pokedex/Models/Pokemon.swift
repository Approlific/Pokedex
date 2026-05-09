//
//  Pokemon.swift
//  Pokedex
//
//  Created by Jerry Toland on 5/9/26.
//

import Foundation

struct Pokemon: Decodable {
    
    let id: Int?
    var name: String?
    var height: Int?
    var isDefault: Bool?
    var order: Int?
    var weight: Int?
    var sprites: Sprite?
    
    enum CodingKeys: String, CodingKey {
        
        case isDefault = "is_default"
        
        case id
        case name
        case height
        case order
        case weight
        case sprites
        
    }
    
}

struct Sprite: Decodable {
    
    var frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        
        case frontDefault = "front_default"
        
    }
    
}
