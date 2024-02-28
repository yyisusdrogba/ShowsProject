//
//  ShowsMapper.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 31/01/24.
//

import Foundation

class ShowsMapper{
    
    func mapp(model ShowEntity: ShowEntity) -> ShowViewModel{
        return ShowViewModel(name: ShowEntity.name, languaje: ShowEntity.language, score: ShowEntity.ratingScore, image: ShowEntity.imageSizes, summary: ShowEntity.summary)
    }
    
}
