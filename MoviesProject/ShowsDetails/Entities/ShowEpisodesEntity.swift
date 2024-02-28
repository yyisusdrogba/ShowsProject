//
//  ShowEpisodesEntity.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 08/02/24.
//

import Foundation

struct ShowEpisodesEntity: Decodable{
    
    let id: Int?
    let name: String?
    let season: Int?
    let number: Int?
    let ratingScore: Double?
    let image: String?
    let summary: String?
    
    enum CodingKeys: String,CodingKey {
        case id
        case name
        case season
        case number
        case ratingScore = "rating"
        case image
        case summary
    }
    
    enum episodeRatingKeys: String, CodingKey{
        case average
    }
    
    enum episodeImageKeys: String,CodingKey{
        case medium
        case original
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let id = try? container.decode(Int.self, forKey: .id){
            self.id = id
        }else{
            self.id = 0
        }
        
        if let name = try? container.decode(String.self, forKey: .name){
            self.name = name
        }else{
            self.name = ""
        }
        
        if let season = try? container.decode(Int.self, forKey: .season){
            self.season = season
        }else{
            self.season = 0
        }
        
        if let number = try? container.decode(Int.self, forKey: .number){
            self.number = number
        }else{
            self.number = 0
        }
        
        if let ratingContainer = try? container.nestedContainer(keyedBy: episodeRatingKeys.self, forKey: .ratingScore) {
            if let rating = try? ratingContainer.decode(Double.self, forKey: .average) {
                self.ratingScore = rating
            } else if let rating = try? ratingContainer.decode(Int.self, forKey: .average) {
                self.ratingScore = Double(rating)
            } else {
                self.ratingScore = 0
            }
        } else {
            self.ratingScore = 0.0
        }
        
        if let imageContainer = try? container.nestedContainer(keyedBy: episodeImageKeys.self, forKey: .image){
            self.image = try imageContainer.decode(String.self, forKey: .medium)
        }else{
            self.image = "https://static-00.iconduck.com/assets.00/no-image-icon-512x512-lfoanl0w.png"
        }
        
        if let summary = try? container.decode(String.self, forKey: .summary){
            self.summary = summary
        }else{
            self.summary = ""
        }
    }
}

