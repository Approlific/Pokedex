//
//  ContentView.swift
//  Pokedex
//
//  Created by Jerry Toland on 5/9/26.
//

import SwiftUI

struct MainView: View {
    
    @Environment(PokemonViewModel.self) var model
    
    var body: some View {
        
        @Bindable var model = model
        
        VStack {
            
            ZStack {
                
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundStyle(.tint)
                
                VStack {
                    
                    HStack {
                        Image(systemName: "circle.circle.fill")
                            .font(.title2)
                        
                        Text("Pokédex")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    
                    HStack {
                        
                        TextField("Enter Pokemon name", text: $model.enteredPokemon)
                            .padding(8)
                            .autocorrectionDisabled()
                            .background(.white)
                            .onSubmit {
                                model.searchPokemon()
                            }
                        
                        Button {
                            
                            model.searchPokemon()
                            
                        } label: {
                            
                            ZStack {
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.white)
                                    .frame(width: 35, height: 35)
                                
                                Text("GO")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.tint)
                                
                            }
                            
                        }
                        
                    }
                    .padding()
                    
                }
                
            }
            .frame(height: 125)
            
            List {
                
                ForEach(model.pokemon, id: \.id) { p in
                    HStack {
                        
                        if let url = p.sprites?.frontDefault {
                         
                            AsyncImage(url: URL(string: url))
                            
                        } else {
                            
                            // TODO: Placeholder image
                            
                        }
                        
                        Text((p.name ?? "").capitalized)
                    }
                    .listRowSeparator(.hidden)
                    .onTapGesture {
                        
                        model.searchedPokemon = p
                        model.isShown = true
                        
                    }
                    
                }
                
            }
            .listStyle(.plain)
            
            HStack {
                
                Button {
                    
                    if model.offset - model.limit <= 0 {
                        
                        model.toggleBackOff = true
                        
                    }
                        
                    model.offset -= model.limit
                    
                    Task {
                        
                        model.getPokemon()
                        
                    }
                    
                } label: {
                    
                    Image(systemName: "arrow.left")
                    Text("Back")
                    
                }
                .disabled(model.toggleBackOff)
                
                Spacer()
                
                Button {
                    
                    model.offset += model.limit
                    
                    Task {
                        
                        model.getPokemon()
                        
                    }
                    
                    if model.offset > 0 {
                        
                        model.toggleBackOff = false
                        
                    }
                    
                } label: {
                    
                    Text("Forward")
                    Image(systemName: "arrow.right")
                    
                }
                
            }
            .padding()
            
        }
        .task {
            
            model.getPokemon()
            
        }
        .sheet(isPresented: $model.isShown) {
            
            PokemonDetailView()
                .presentationDetents([.medium])
            
        }
    }
}

#Preview {
    MainView()
        .environment(PokemonViewModel())
}
