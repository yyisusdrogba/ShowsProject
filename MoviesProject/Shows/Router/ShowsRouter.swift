//
//  ShowsRouter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 07/02/24.
//

import Foundation
import UIKit

class ShowsRouter: ShowsRouterProtocol{
    
    var favoriteRouter: FavoriteRouter?
    var routerDetail: ShowDetailRouter?
    var showsViewController: ShowsViewController?
    
    
    func createView() -> UIViewController{
        routerDetail = ShowDetailRouter()
        favoriteRouter = FavoriteRouter()
        let showsInteractor = ShowsInteractor()
        let showsPresenter = ShowsPresenter(interactor: showsInteractor, router: self)
        showsViewController = ShowsViewController(presenter: showsPresenter)
        showsPresenter.ui = showsViewController
        guard let view = showsViewController else {return ShowsViewController(presenter: showsPresenter)}
        return view
    }
    
    func getShowDetail(showId id: Int){
        guard let vcShows = showsViewController else {return}
        routerDetail?.presentDetailsView(fromViewController:vcShows , movieId: id)
    }
    
    func favoriteDetails(favoriteModel: FavoriteViewModel){
        favoriteRouter?.getFavorite(model: favoriteModel)
    }
}
