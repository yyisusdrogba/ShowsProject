//
//  ShowDetailInteractor.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 07/02/24.
//

import Foundation

protocol ShowDetailInteractorProtocol{
    func getShowDetail(idShow id: Int) async -> ShowDetailEntity
    func getShowEpisodes(idShow id: Int) async -> [ShowEpisodesEntity]
    func getShowCast(idShow id: Int) async -> [ShowCastEntity]
}

class ShowDetailInteractor: ShowDetailInteractorProtocol{
    
    func getShowDetail(idShow id: Int) async -> ShowDetailEntity{
        let url = URL(string:"https://api.tvmaze.com/shows/\(id)")!
        let (data,_) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode(ShowDetailEntity.self, from: data)
    }
    
    
    func getShowEpisodes(idShow id: Int) async -> [ShowEpisodesEntity]{
        let url = URL(string: "https://api.tvmaze.com/shows/\(id)/episodes")!
        let (data,_) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode([ShowEpisodesEntity].self, from: data)
    }
    
    func getShowCast(idShow id: Int) async -> [ShowCastEntity]{
        let url = URL(string: "https://api.tvmaze.com/shows/\(id)/cast")!
        let (data,_) = try! await URLSession.shared.data(from: url)
        return try! JSONDecoder().decode([ShowCastEntity].self, from: data)
        
    }
}

