//
//  FavoriteDetailPresenter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 04/03/24.
//

import Foundation

//protocol favoriteDetails{
//    func getDetail(details: DetailsViewModel)
//    func getEpisodes(episodes: [EpisodesViewModel])
//    func getCast(cast: [CastViewModel])
//}

class FavoriteDetailPresenter{
    
    var router: FavoriteDetailRouter
    var interactor: FavoriteDetailInteractor
    var movieId: Int
    var details: DetailsViewModel!
    var episodes: [EpisodesViewModel] = []
    var cast: [CastViewModel] = []
    let mapper: DetailsMapper
    var ui: DetailsUI?
    
    
    
    init(router: FavoriteDetailRouter, interactor: FavoriteDetailInteractor, movieId: Int, mapper:DetailsMapper = DetailsMapper()) {
        self.router = router
        self.interactor = interactor
        self.movieId = movieId
        self.mapper = mapper
    }
    
    func updateUI() async{
        Task{
            let showDetails = await interactor.getShowDetail(idShow: movieId)
            let showEpisodes = await interactor.getShowEpisodes(idShow: movieId)
            let showCast = await interactor.getShowCast(idShow: movieId)
            details = mapper.detailsMapper(model: showDetails)
            episodes = showEpisodes.map(mapper.episodesMapper(model:))
            cast = showCast.map(mapper.castMapper(model:))
            await MainActor.run{
                self.ui?.getDetail(details: details)
                self.ui?.getEpisodes(episodes: episodes)
                self.ui?.getCast(cast: cast)
            }
        }
    }
}
