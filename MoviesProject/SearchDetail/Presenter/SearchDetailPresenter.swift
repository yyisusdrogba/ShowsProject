//
//  SearchDetailPresenter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 14/03/24.
//

import Foundation

protocol SearchDetails:AnyObject{
    func getDetail(details: DetailsViewModel)
    func getEpisodes(episodes: [EpisodesViewModel])
    func getCast(cast: [CastViewModel])
}

class SearchDetailPresenter{
    
    var ui: SearchDetails?
    let interactor: SearchDetailInteractor
    let mapper: DetailsMapper
    let movieId:Int
    var details: DetailsViewModel!
    var episodes: [EpisodesViewModel] = []
    var cast: [CastViewModel] = []
    
    init(interactor: SearchDetailInteractor, mapper: DetailsMapper = DetailsMapper(),movieId:Int) {
        self.interactor = interactor
        self.mapper = mapper
        self.movieId = movieId
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
