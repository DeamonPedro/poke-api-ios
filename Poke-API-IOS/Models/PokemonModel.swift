//
//  PokemonModel.swift
//  Poke-API-IOS
//
//  Created by Pedro Carneiro on 28/08/23.
//

struct Pokemon: Decodable {
    let title: String
    let posterPath: String
    let overview: String
    let voteAverage: Double
    let releaseDate: String
    let originalLanguage: String
}

