//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Jerry Toland on 5/9/26.
//

import SwiftUI

@main
struct PokedexApp: App {
    
    @State var model = PokemonViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(model)
        }
    }
}
