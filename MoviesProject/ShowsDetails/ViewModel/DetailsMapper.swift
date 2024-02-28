//
//  DetailsMapper.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 09/02/24.
//

import Foundation

class DetailsMapper{
    
    func episodesMapper(model: ShowEpisodesEntity) -> EpisodesViewModel{
        return EpisodesViewModel(name: model.name, season: model.season , episodeNumber: model.number, rating: model.ratingScore, image: model.image, summary: model.summary)
    }
    
    func castMapper(model: ShowCastEntity) -> CastViewModel{
        return CastViewModel(name: model.personName, image: model.personImageMedium, country: model.personCountry, character: model.characterName, characterImage: model.characterImageMedium)
    }
    
    func detailsMapper(model: ShowDetailEntity) -> DetailsViewModel{
        return DetailsViewModel(name: model.name, site: model.officialSite, ratingScore: model.ratingScore, network: model.network, image: model.imageZises, summary: model.summary)
    }
}
