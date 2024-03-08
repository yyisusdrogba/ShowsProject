//
//  FavoriteViewController.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 29/01/24.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        setUpView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(hex: "#3F5E5A")
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
    
    func getAllItems(){
        do{
            presenter.models = try context.fetch(FavoriteItems.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{

        }
    }
    
    func deleteItem(item:FavoriteItems){
        context.delete(item)
        
        do{
            try context.save()
            getAllItems()
        }
        catch{
            
        }
    }
    
}

extension FavoriteViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let model = presenter.models[indexPath.row]
        cell.backgroundColor = UIColor(hex: "#2D2D2A")
        print("MODELOS:\(model)")
        cell.configure(model: model)
        return cell
    }

}

//extension FavoriteViewController: UpdateUI{
//    func obtainFavoritesShows(shows: [FavoriteViewModel]) {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
//    }
//}

extension FavoriteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.passShowSelected(indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Delete") { action, view, completionHandler in
            completionHandler(true)
            let item = self.presenter.models[indexPath.row]
            self.deleteItem(item: item)
        }
        action.backgroundColor = UIColor(hex: "#3F5E5A")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
    
}

