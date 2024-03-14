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
    var viewModel: [SearchViewModel] = []
    var soughtModel: [SoughtShow] = []
    
    init(interactor: SearchInteractor,mapper: SearchMapper = SearchMapper()) {
        self.interactor = interactor
        self.mapper = mapper
    }
    
    func soughtShow(show: String) async{
        soughtModel = await interactor.searchShow(show: show)
        viewModel = soughtModel.map(mapper.mapper(model:))
        ui?.updateUI(model: viewModel)
    }
}
