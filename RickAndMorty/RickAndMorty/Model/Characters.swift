//
//  Characters.swift
//  RickAndMorty
//
//  Created by Isiah Parra on 6/1/22.
//

import Foundation

struct TopLevelDictionary: Decodable {
    let info: Info
    let results: [ResultsDictionary]
}
// endPoint1
struct Info: Decodable {
//    private enum Keys: String, CodingKey {
//        case nextURL = "next"
//    }
    let next: String
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
        case imageString = "image"
        
    }
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: OriginDictionary
    let location: LocationDictionary
    let imageString: String?
}
//endPoint 2

struct OriginDictionary: Decodable {
 
    let name: String
}

struct LocationDictionary: Decodable {
    
    let name: String
}
//endpoint 3
