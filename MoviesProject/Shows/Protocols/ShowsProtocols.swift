//
//  ShowsProtocols.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 15/02/24.
//

import Foundation
import UIKit

/*---View---*/
protocol ShowsUI:AnyObject{
    func getShows(shows: [ShowViewModel])
}
/*---Interactor----*/
protocol ShowsInteractorProtocol{
    func requestAPI() async -> [ShowEntity]
}
/*----Presenter---*/
protocol ShowsPresenterProtocol:AnyObject{
    var ui: ShowsUI? {get}
    var viewModel: [ShowViewModel] {get}
    var showsData: [ShowEntity] {get}
    func updateUI() async
    func tapShow(indexPath: Int)
    func addFavorite(indexPath: Int)
}
/*---Router----*/
protocol ShowsRouterProtocol: AnyObject{
    var routerDetail: ShowDetailRouter? { get  }
    var showsViewController: ShowsViewController? { get  }
    func getShowDetail(showId id: Int)
}



