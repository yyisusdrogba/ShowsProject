//
//  SearchInteractor.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 13/03/24.
//

import Foundation

class SearchInteractor{
    
    func searchShow(show: String) async -> [SoughtShow]{
        
        let url = URL(string: "https://api.tvmaze.com/search/shows?q=\(show)")!
        let (data,_) = try! await  URLSession.shared.data(from: url)
        let showModel = try! JSONDecoder().decode([SoughtShow].self, from: data)
        let pintadoData = String(data: data, encoding: .utf8)
        return showModel
    }
    
}
