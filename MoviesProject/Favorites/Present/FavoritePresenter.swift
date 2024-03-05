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
    var router: FavoriteRouter
    
    init(router: FavoriteRouter) {
        self.router = router
    }
    
    func passShows() {
        ui?.obtainFavoritesShows(shows: favoritesShows)
    }
    
    func passShowSelected(indexPath: Int){
        let id = favoritesShows[indexPath].id
        router.getFavoriteId(id: id)
    }
    
}
