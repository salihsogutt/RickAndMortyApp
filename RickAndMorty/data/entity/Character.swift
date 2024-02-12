//
//  KarakterList.swift
//  RickAndMorty
//
//  Created by salih söğüt on 27.01.2024.
//

import Foundation

struct CharacterResponse: Codable{
    let results: [Character]?
}

struct Character: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}
