//
//  ShowsViewController.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 29/01/24.
//

import UIKit

class ShowsViewController: UIViewController {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ShowsTableViewCell.self, forCellReuseIdentifier: "ShowsTableViewCell")
        return table
    }()
    
    let presenter: ShowsPresenterProtocol
    
    init(presenter: ShowsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        view.backgroundColor = UIColor(hex: "#3F5E5A")
        Task{
            await presenter.updateUI()
        }
    }
    
    
    private func setUpViews(){
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(hex: "#3F5E5A")
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension ShowsViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ShowsTableViewCell" , for: indexPath) as! ShowsTableViewCell
        let model = presenter.viewModel[indexPath.row]
        cell.configure(model: model)
        cell.backgroundColor = UIColor(hex: "#2D2D2A")
        return cell
    }
    
}

extension ShowsViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.tapShow(indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Add to favorite") { action, view, completionHandler in
            completionHandler(true)
            self.presenter.addFavorite(indexPath: indexPath.row)
        }
        action.backgroundColor = UIColor(hex: "#3F5E5A")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
    
}

extension ShowsViewController: ShowsUI{
    func getShows(shows: [ShowViewModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
