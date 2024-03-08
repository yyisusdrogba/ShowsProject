//
//  ShowsPresenter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 30/01/24.
//

import Foundation

class ShowsPresenter:ShowsPresenterProtocol{

    weak var ui: ShowsUI?
    var viewModel: [ShowViewModel] = []
    let interactor: ShowsInteractorProtocol
    var showsData: [ShowEntity] = []
    let mapper: ShowsMapper
    let router: ShowsRouterProtocol
    let favoriteInteractor: FavoriteInteractor
    
    init(interactor: ShowsInteractorProtocol,mapper: ShowsMapper = ShowsMapper(),router: ShowsRouterProtocol,favoriteInteractor: FavoriteInteractor) {
        self.interactor = interactor
        self.mapper = mapper
        self.router = router
        self.favoriteInteractor = favoriteInteractor
    }
    
    func updateUI() async {
        Task{
            showsData = await interactor.requestAPI()
            viewModel = showsData.map(mapper.mapp(model:))
            ui?.getShows(shows: viewModel)
        }
    }
    
    func tapShow(indexPath: Int) {
        let showId = showsData[indexPath].id
        router.getShowDetail(showId: showId)
    }
    
    func addFavorite(indexPath: Int){
        let showID = showsData[indexPath].id
        let showName = showsData[indexPath].name
        let showImage = showsData[indexPath].imageSizes
        let favoriteModel = FavoriteViewModel(id: showID, name: showName, image: showImage)
        favoriteInteractor.getFavoriteShow(model: favoriteModel)
        
    }
    
}
