//
//  FavoriteDetailRouter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 04/03/24.
//

import Foundation
import UIKit

class FavoriteDetailRouter{
        
    func presentDetailsView(fromViewController: UIViewController,movieId: Int){
     
        let interactor = FavoriteDetailInteractor()
        let presenter = FavoriteDetailPresenter(router: self, interactor: interactor, movieId: movieId)
        let favoriteDetailViewController = FavoriteDetailViewController(presenter: presenter)
        presenter.ui = favoriteDetailViewController
        
        fromViewController.present(favoriteDetailViewController, animated: true)
    }
}
