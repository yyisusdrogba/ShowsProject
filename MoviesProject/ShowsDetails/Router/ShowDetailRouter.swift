//
//  ShowDetailRouter.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 07/02/24.
//

import Foundation
import UIKit

class ShowDetailRouter{
    
    func presentDetailsView(fromViewController: UIViewController,movieId id: Int){
        
        let interactor = ShowDetailInteractor()
        let presenter = ShowDetailPresenter(interactor: interactor, movieId: id)
        let view = ShowDetailView(presenter: presenter)
        presenter.ui = view
            
        fromViewController.present(view, animated: true)
        
    }
}
