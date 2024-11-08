//
//  ItemsTabBarController.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 29/01/24.
//

import UIKit

class ItemsTabBarController: UITabBarController, UITabBarControllerDelegate{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


            
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        delegate = self
        view.backgroundColor = UIColor(hex: "#3F5E5A")
    }
        
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if let navigationController = viewController as? UINavigationController{
            if let favoriteViewController = navigationController.topViewController as? FavoriteViewController{
                do{
                    DispatchQueue.main.async {
                        favoriteViewController.tableView.reloadData()
//                        favoriteViewController.presenter.passShows()
                    }
                    favoriteViewController.presenter.models = try context.fetch(FavoriteItems.fetchRequest())
                }
                catch{
                    
                }
            }
        }
        
    }
    
    private func configureItems(){

        //MARK: - Configuration Views
        let favoriteRouter = FavoriteRouter()
        let favoriteInteractor = FavoriteInteractor()
        let favoritePresenter = FavoritePresenter(router: favoriteRouter, interactor: favoriteInteractor)
        let favoriteView = FavoriteViewController(presenter: favoritePresenter)
//        favoritePresenter.ui = favoriteView
        favoriteInteractor.presenter = favoritePresenter
        favoriteRouter.favoriteViewController = favoriteView
        favoriteRouter.favoriteDetailRouter = FavoriteDetailRouter()
        
        let showsInteractor = ShowsInteractor()
        let showsRouter = ShowsRouter()
        let showsPresenter = ShowsPresenter(interactor: showsInteractor, router: showsRouter, favoriteInteractor: favoriteInteractor)
        let showsViewController = ShowsViewController(presenter: showsPresenter)
        showsRouter.routerDetail = ShowDetailRouter()
        showsRouter.showsViewController = showsViewController
        showsPresenter.ui = showsViewController
        
        let searchInteractor = SearchInteractor()
        let searchRouter = SearchRouter()
        let searchPresenter = SearchPresenter(interactor: searchInteractor, router: searchRouter, favoriteInteractor: favoriteInteractor)
        let searchViewController = SearchViewController(presenter: searchPresenter)
        searchRouter.searchDetailRouter = SearchDetailRouter()
        searchRouter.view = searchViewController
        
        //MARK: - ViewControllers
        let vcShowViewController = showsViewController
        let vcFavoriteViewContriller = favoriteView
        let vcSekeerViewController = searchViewController
                        
        
        //MARK: - tabBar Styles
        vcShowViewController.tabBarItem.image = UIImage(systemName: "appletvremote.gen2.fill")
        vcFavoriteViewContriller.tabBarItem.image = UIImage(systemName: "star.circle.fill")
        vcSekeerViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")
        
        vcShowViewController.tabBarItem.title = "Shows"
        vcFavoriteViewContriller.tabBarItem.title = "Favorite"
        vcSekeerViewController.tabBarItem.title = "Search"
        
        tabBar.tintColor = UIColor(hex: "#20FC8F")
        tabBar.barTintColor = UIColor(hex: "#3F5E5A")
        
        //MARK: - Items TabBar
        let nvShow = UINavigationController(rootViewController: vcShowViewController)
        let nvFavorite = UINavigationController(rootViewController: vcFavoriteViewContriller)
        let nvSearch = UINavigationController(rootViewController: vcSekeerViewController)
        
        setViewControllers([nvShow,nvFavorite,nvSearch], animated: true)
        
    }

}
