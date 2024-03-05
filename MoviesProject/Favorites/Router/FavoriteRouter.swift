//
//  FavoriteRouter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 23/02/24.
//

import Foundation
import UIKit


class FavoriteRouter{
    
    var favoriteDetailRouter: FavoriteDetailRouter?
    var favoriteViewController: FavoriteViewController?
    
    func getFavoriteId(id:Int){
        guard let favoriteVC = favoriteViewController else{return}
        favoriteDetailRouter?.presentDetailsView(fromViewController: favoriteVC, movieId: id)
    }

}
