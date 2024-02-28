//
//  ShowsInteractor.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 29/01/24.
//

import Foundation

class ShowsInteractor: ShowsInteractorProtocol{
    
    func requestAPI() async -> [ShowEntity] {
        let urlShows = URL(string: "https://api.tvmaze.com/shows")!
        let (data,_) = try! await URLSession.shared.data(from: urlShows)
        let showsModel = try! JSONDecoder().decode([ShowEntity].self, from: data)
        
        return showsModel

    }
    
}

class ShowsinteractorMock: ShowsInteractorProtocol{
    func requestAPI() async -> [ShowEntity] {
        return [ShowEntity(id: 1, name: "MOVIE", language: "ENGLISH", genres: ["Horror"], ratingScore: 8.8, imageSizes: "image.jpg", summary: "This is the summary"),ShowEntity(id: 1, name: "MOVIE", language: "ENGLISH", genres: ["Horror"], ratingScore: 8.8, imageSizes: "image.jpg", summary: "This is the summary"),ShowEntity(id: 1, name: "MOVIE", language: "ENGLISH", genres: ["Horror"], ratingScore: 8.8, imageSizes: "image.jpg", summary: "This is the summary"),ShowEntity(id: 1, name: "MOVIE", language: "ENGLISH", genres: ["Horror"], ratingScore: 8.8, imageSizes: "image.jpg", summary: "This is the summary"),ShowEntity(id: 1, name: "MOVIE", language: "ENGLISH", genres: ["Horror"], ratingScore: 8.8, imageSizes: "image.jpg", summary: "This is the summary"),ShowEntity(id: 1, name: "MOVIE", language: "ENGLISH", genres: ["Horror"], ratingScore: 8.8, imageSizes: "image.jpg", summary: "This is the summary"),ShowEntity(id: 1, name: "MOVIE", language: "ENGLISH", genres: ["Horror"], ratingScore: 8.8, imageSizes: "image.jpg", summary: "This is the summary")]
    }
}
