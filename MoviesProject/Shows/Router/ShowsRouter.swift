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
        
    func getShowDetail(showId id: Int){
        guard let vcShows = showsViewController else {return}
        routerDetail?.presentDetailsView(fromViewController:vcShows , movieId: id)
    }
    
}
