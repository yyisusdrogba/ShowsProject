//
//  SearchPresenter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 13/03/24.
//

import Foundation

protocol SoughtUI{
    func updateUI(model: [SearchViewModel])
}

class SearchPresenter{
    
    var ui: SoughtUI?
    var interactor: SearchInteractor
    var mapper: SearchMapper
    var router: SearchRouter
    var viewModel: [SearchViewModel] = []
    var soughtModel: [SoughtShow] = []
    let favoriteInteractor: FavoriteInteractor
    
    init(interactor: SearchInteractor,router: SearchRouter,favoriteInteractor: FavoriteInteractor,mapper: SearchMapper = SearchMapper()) {
        self.interactor = interactor
        self.mapper = mapper
        self.router = router
        self.favoriteInteractor = favoriteInteractor
    }
    
    func soughtShow(show: String) async{
        soughtModel = await interactor.searchShow(show: show)
        viewModel = soughtModel.map(mapper.mapper(model:))
        ui?.updateUI(model: viewModel)
    }
    
    func showSelected(indexPath: Int){
        let id = soughtModel[indexPath].id
        router.obtainShowId(id: id)
    }
    
    func addFavorite(indexPath: Int){
        let showID = soughtModel[indexPath].id
        let showName = soughtModel[indexPath].name
        let showImage = soughtModel[indexPath].imageSizes!
        let favoriteModel = FavoriteViewModel(id: showID, name: showName, image: showImage)
        favoriteInteractor.getFavoriteShow(model: favoriteModel)
        print("Este es el favorite Model para favoritos:\(favoriteModel)")
        
    }
}
