//
//  SearchDetailRouter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 14/03/24.
//

import Foundation
import UIKit

class SearchDetailRouter{
    func getShowDetail(fromViewController: UIViewController,id: Int){
        let interactor = SearchDetailInteractor()
        let presenter = SearchDetailPresenter(interactor: interactor, movieId: id)
        let view = SearchDetailViewController(presenter: presenter)
        presenter.ui = view
        
        fromViewController.present(view, animated: true)
    }
}
