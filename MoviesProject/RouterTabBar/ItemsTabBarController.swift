//
//  ItemsTabBarController.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 29/01/24.
//

import UIKit

class ItemsTabBarController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        view.backgroundColor = UIColor(hex: "#3F5E5A")
    }
    
    
    private func configureItems(){

        let router = ShowsRouter()
        let vcShowViewController = router.createView()
        let vcFavoriteViewContriller = FavoriteViewController()
        let vcSekeerViewController = SearchViewController()
                        
        vcShowViewController.tabBarItem.image = UIImage(systemName: "appletvremote.gen2.fill")
        vcFavoriteViewContriller.tabBarItem.image = UIImage(systemName: "star.circle.fill")
        vcSekeerViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")
        
        vcShowViewController.tabBarItem.title = "Shows"
        vcFavoriteViewContriller.tabBarItem.title = "Favorite"
        vcSekeerViewController.tabBarItem.title = "Search"
        
        tabBar.tintColor = UIColor(hex: "#20FC8F")
        tabBar.barTintColor = UIColor(hex: "#3F5E5A")
        
        
        let nvShow = UINavigationController(rootViewController: vcShowViewController)
        let nvFavorite = UINavigationController(rootViewController: vcFavoriteViewContriller)
        let nvSearch = UINavigationController(rootViewController: vcSekeerViewController)
        
        setViewControllers([nvShow,nvFavorite,nvSearch], animated: true)
        
    }

}
