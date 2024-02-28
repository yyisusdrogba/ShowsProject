//
//  ShowDetailPresenter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 07/02/24.
//

import Foundation

protocol ShowDetailPresenterProtocol: AnyObject{
    
}

protocol DetailsUI:AnyObject{
    
    func getDetail(details: DetailsViewModel)
    func getEpisodes(episodes: [EpisodesViewModel])
    func getCast(cast: [CastViewModel])
    
}

class ShowDetailPresenter{
    
    let interactor: ShowDetailInteractorProtocol
    let movieId: Int
    var ui: DetailsUI?
    var details: DetailsViewModel!
    var episodes: [EpisodesViewModel] = []
    var cast: [CastViewModel] = []
    let mapper: DetailsMapper
    
    init(interactor: ShowDetailInteractorProtocol, movieId: Int,mapper: DetailsMapper = DetailsMapper()) {
        self.interactor = interactor
        self.movieId = movieId
        self.mapper = mapper
    }
    
    func updateUI() async {
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
