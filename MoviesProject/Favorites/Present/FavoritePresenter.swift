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
//    var favoritesShows:[FavoriteViewModel] = []
    var models: [FavoriteItems] = []
    var router: FavoriteRouter
    var interactor: FavoriteInteractor
    
    init(router: FavoriteRouter,interactor:FavoriteInteractor) {
        self.router = router
        self.interactor = interactor
    }
    
//    func passShows() {
//        ui?.obtainFavoritesShows(shows: favoritesShows)
//    }
    
    func passShowSelected(indexPath: Int){
        let id = models[indexPath].id
        let converStringInInt = Int(id!)
        router.getFavoriteId(id: converStringInInt!)
    }
    
    func deleteShowSlected(indexPath: Int){
        let show = models[indexPath]
        interactor.deleteItem(item: show)
    }
    
}
