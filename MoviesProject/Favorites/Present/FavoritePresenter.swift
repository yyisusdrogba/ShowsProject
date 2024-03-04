//
//  FavoritePresenter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 28/02/24.
//

import Foundation

protocol UpdateUI{
    func obtainFavoritesShows(shows:[FavoriteViewModel])
}

class FavoritePresenter{
      
    var ui: UpdateUI?
    var favoritesShows:[FavoriteViewModel] = []

    func passShows() {
        ui?.obtainFavoritesShows(shows: favoritesShows)
    }
    
}
