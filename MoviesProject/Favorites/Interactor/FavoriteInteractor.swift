//
//  FavoriteInteractor.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 28/02/24.
//

import Foundation

class FavoriteInteractor{
    
    var presenter: FavoritePresenter?
    
    func getFavoriteShow(model: FavoriteViewModel){
        
        if let presenter = presenter {
            if presenter.favoritesShows.contains(where: { $0.id == model.id}){
                print("MISMO ID")
            }else{
                presenter.favoritesShows.append(model)
            }
        }
    }
    
}
