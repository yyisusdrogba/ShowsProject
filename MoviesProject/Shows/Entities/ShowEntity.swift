//
//  ShowEntity.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 29/01/24.
//

import Foundation


struct ShowEntity: Decodable {
    let id: Int
    let name: String
    let language: String
    let genres: [String]
    let ratingScore: Double?
    let imageSizes: String
    let summary: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case language
        case genres
        case rating = "rating"
        case image = "image"
        case summary
    }
    
    enum RatingKeys: String, CodingKey {
        case average
    }
    
    enum imageSize: String, CodingKey {
        case medium
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.language = try container.decode(String.self, forKey: .language)
        self.genres = try container.decode([String].self, forKey: .genres)
        let ratingContainer = try container.nestedContainer(keyedBy: RatingKeys.self, forKey: .rating)
        self.ratingScore = try ratingContainer.decode(Double?.self, forKey: .average)
        let imageContainer = try container.nestedContainer(keyedBy: imageSize.self, forKey: .image)
        self.imageSizes = try imageContainer.decode(String.self, forKey: .medium)
        self.summary = try container.decode(String.self, forKey: .summary)
    }
    
    init(id: Int,name: String,language: String,genres:[String],ratingScore: Double,imageSizes: String,summary: String) {
        self.id = id
        self.name = name
        self.language = language
        self.genres = genres
        self.ratingScore = ratingScore
        self.imageSizes = imageSizes
        self.summary = summary
    }
}
