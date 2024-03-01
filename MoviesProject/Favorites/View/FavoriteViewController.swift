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
        view.backgroundColor = .green
    }
}

extension FavoriteViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        return cell
    }

}

