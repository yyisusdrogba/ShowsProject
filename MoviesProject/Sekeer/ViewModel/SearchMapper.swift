//
//  SearchMapper.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 13/03/24.
//

import Foundation

class SearchMapper{
    func mapper(model: SoughtShow) -> SearchViewModel{
        if model.imageSizes == "" {
            return .init(name: model.name , languaje: model.language, score: model.ratingScore ?? 0.0, image: "showNotAvailable", summary: model.summary)
        }
        return .init(name: model.name , languaje: model.language, score: model.ratingScore ?? 0.0, image: model.imageSizes ?? "", summary: model.summary)
    }
}
