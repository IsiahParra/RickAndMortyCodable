//
//  Characters.swift
//  RickAndMorty
//
//  Created by Isiah Parra on 6/1/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    private enum CodingKeys: String,CodingKey {
        case results
    }
    let results: [ResultsDictionary]
}

struct ResultsDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case status = "status"
        case species = "species"
        case gender = "gender"
        case origin
        case location
        case image
        
    }
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: [OriginDictionary]
    let location: [LocationDictionary]
    let image: String
}
struct OriginDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
    }
    let name: String
}

struct LocationDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
    }
    let name: String
}
