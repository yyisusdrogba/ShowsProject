//
//  SearchRouter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 14/03/24.
//

import Foundation

class SearchRouter{
    
    var searchDetailRouter: SearchDetailRouter?
    var view: SearchViewController?
    
    func obtainShowId(id: Int){
        guard let viewController = view else {return}
        searchDetailRouter?.getShowDetail(fromViewController: viewController, id: id)
    }
    
}
