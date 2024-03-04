//
//  FavoriteViewController.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 29/01/24.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "favoriteTableViewCell")
        return table
    }()
    
    let presenter: FavoritePresenter
    
    init(presenter: FavoritePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        presenter.passShows()
        setUpView()
        tableView.dataSource = self
        tableView.delegate = self
        view.backgroundColor = .green
    }
    
    func setUpView(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
}

extension FavoriteViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.favoritesShows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let model = presenter.favoritesShows[indexPath.row]
        print("MODELOS:\(model)")
        cell.configure(model: model)
        return cell
    }

}

extension FavoriteViewController: UpdateUI{
    func obtainFavoritesShows(shows: [FavoriteViewModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension FavoriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

