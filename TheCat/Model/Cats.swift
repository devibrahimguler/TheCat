//
//  Cats.swift
//  TheCat
//
//  Created by İbrahim Güler on 11.04.2022.
//

import Foundation

struct Cats :DataModel, Codable, Identifiable {
    
    let id : String?
    let image : CatsImages?
    let name : String?
    let description : String?
    let origin : String?
    let wikipedia_url : String?
    let life_span : String?
    let dog_friendly : Int?
    let reference_image_id : String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case image = "image"
        case name = "name"
        case description = "description"
        case origin = "origin"
        case wikipedia_url = "wikipedia_url"
        case life_span = "life_span"
        case dog_friendly = "dog_friendly"
        case reference_image_id = "reference_image_id"
  
    }
}

struct CatsImages :Codable {
    let id : String?
    let url : String?
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case url = "url"
    }
}

struct CatsFavorite :DataModel, Identifiable, Codable {
    let id : Int
    let image : CatsImages?
    
    private enum CodingKeys : String, CodingKey {
        case id = "id"
        case image = "image"
    }
}

protocol DataModel {}
