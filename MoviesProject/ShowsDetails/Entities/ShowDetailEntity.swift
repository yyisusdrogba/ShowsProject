//
//  ShowDetailEntity.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 07/02/24.
//

import Foundation

struct ShowDetailEntity: Decodable {
    let name: String?
    let officialSite: String?
    let ratingScore: Double?
    let network: String?
    let imageZises: String?
    let summary: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case officialSite
        case ratingScore = "rating"
        case network
        case imageZises = "image"
        case summary
    }
    
    enum detailRatingKeys: String, CodingKey {
        case average
    }
    
    enum detailNetworkKeys: String,CodingKey{
        case name
    }
    
    enum detailImageKeys: String, CodingKey {
        case medium
        case original
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let name = try? container.decode(String.self, forKey: .name){
            self.name = name
        }else{
            self.name = ""
        }
        
        if let officialSite = try? container.decode(String.self, forKey: .officialSite){
            self.officialSite = officialSite
        }else{
            self.officialSite = "https://support.google.com/webmasters/answer/2445990?hl=es"
        }
        
        if let ratingContainer = try? container.nestedContainer(keyedBy: detailRatingKeys.self, forKey: .ratingScore) {
            self.ratingScore = try ratingContainer.decode(Double.self, forKey: .average)
        } else {
            self.ratingScore = 0.0
        }
        
        if let networkContainer = try? container.nestedContainer(keyedBy: detailNetworkKeys.self, forKey: .network){
            self.network = try networkContainer.decode(String.self, forKey: .name)
        }else{
            self.network = ""
        }

        if let imageContainer =  try? container.nestedContainer(keyedBy: detailImageKeys.self, forKey: .imageZises){
            self.imageZises = try imageContainer.decode(String.self, forKey: .medium)
        }else{
            self.imageZises = ""
        }

        if let summary = try? container.decode(String.self, forKey: .summary){
            self.summary = summary
        }else{
            self.summary = ""
        }
    }
}
