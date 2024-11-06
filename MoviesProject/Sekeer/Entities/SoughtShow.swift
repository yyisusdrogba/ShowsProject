//
//  SoughtShow.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 13/03/24.
//

import Foundation


struct SoughtShow: Decodable {
    
    let id: Int
    let name: String
    let language: String
    let genres: [String]
    var ratingScore: NSNumber?
    let imageSizes: String?
    let summary: String
    
    enum CodingKeys: String, CodingKey {
       case show
    }
    
    enum SearchShowDecode: String,CodingKey{
        case id
        case name
        case languaje
        case genres
        case ratingScore = "rating"
        case imageSizes = "image"
        case summary
    }
        
    enum RatingKeys: String, CodingKey {
        case average
    }
    
    enum imageSize: String, CodingKey {
        case medium
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let showContainer = try container.nestedContainer(keyedBy: SearchShowDecode.self, forKey: .show)
        
        if let id = try? showContainer.decode(Int.self, forKey: .id){
            self.id = id
        }else{
            self.id = 0
        }
        
        if let name =  try? showContainer.decode(String.self, forKey: .name){
            self.name = name
        }else{
            self.name = ""
        }
        
        if let languaje = try? showContainer.decode(String.self, forKey: .languaje){
            self.language = languaje
        }else{
            self.language = ""
        }
        
        if let genres = try? showContainer.decode([String].self, forKey: .genres){
            self.genres = genres
        }else{
            self.genres = [""]
        }
        
        if let ratingContainer = try? showContainer.nestedContainer(keyedBy: RatingKeys.self, forKey: .ratingScore) {
            if let decodedRating = try? ratingContainer.decode(Double.self, forKey: .average) {
                self.ratingScore = NSNumber(value: decodedRating)
            } else if let decodedRating = try? ratingContainer.decode(Int.self, forKey: .average) {
                self.ratingScore = NSNumber(value: decodedRating)
            } else if let decodedRating = try? ratingContainer.decode(Float.self, forKey: .average) {
                self.ratingScore = NSNumber(value: decodedRating)
            } else {
                self.ratingScore = nil
            }
        } else {
            self.ratingScore = 0
        }
        
        if let imageContainer = try? showContainer.nestedContainer(keyedBy: imageSize.self, forKey: .imageSizes){
            self.imageSizes = try imageContainer.decode(String.self, forKey: .medium)
        }else{
            self.imageSizes = ""
        }
        
        if let summary = try? showContainer.decode(String.self, forKey: .summary){
            self.summary = summary
        }else{
            self.summary = ""
        }
        
    }
    
}
