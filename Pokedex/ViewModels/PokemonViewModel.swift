//
//  PokemonViewModel.swift
//  Pokedex
//
//  Created by Jerry Toland on 5/9/26.
//

import Foundation

@Observable
class PokemonViewModel {
    
    var enteredPokemon: String = ""
    var searchedPokemon: Pokemon = Pokemon(id: 0, name: "Pokemon Not Found")
    var pokeList: ListItem = ListItem()
    var pokemon: [Pokemon] = []
    var toggleBackOff = true
    var offset = 0
    var isShown = false
    
    let limit = 10
    let service = DataService()
    
    func getPokemon() {
        
        Task {
            
            pokeList = await service.getPokemonList(limit: limit, offset: offset)
            pokemon = await service.getPokemonFromList(list: pokeList)
            
        }
        
    }
    
}
