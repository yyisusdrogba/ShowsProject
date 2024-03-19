//
//  SearchViewController.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 29/01/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = UITableView.automaticDimension
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchTableViewCell")
        return table
    }()
    
    let textField: UITextField = {
        let text = UITextField()
        let atributosPlaceholder: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(hex: "#9b9b9b"),
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let placeholder = NSAttributedString(string: "Search The Show", attributes: atributosPlaceholder)
        text.attributedPlaceholder = placeholder
        text.translatesAutoresizingMaskIntoConstraints = false
        text.returnKeyType = .done
        text.backgroundColor = UIColor(hex: "#FFFFFF")
        text.layer.cornerRadius = 10.0
        return text
    }()
    
    let btnSearch: UIButton = {
        var configurate = UIButton.Configuration.bordered()
        configurate.image = UIImage(named: "buscar")
        let button = UIButton(type: .system)
        button.configuration = configurate
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(getShowsWithBtn), for: .touchUpInside)
        return button
    }()
    
    var presenter: SearchPresenter
    
    init(presenter: SearchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        configurateViews()
    }
    
    func configurateViews(){
        
        view.addSubview(textField)
        view.addSubview(tableView)
        view.addSubview(btnSearch)
        tableView.backgroundColor = UIColor(hex: "#3F5E5A")
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: btnSearch.leadingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 36),
            
            btnSearch.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            btnSearch.leadingAnchor.constraint(equalTo: textField.trailingAnchor),
            btnSearch.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            btnSearch.widthAnchor.constraint(equalToConstant: 60),
            btnSearch.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor,constant: 28),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
        ])
    }
    
    @objc func getShowsWithBtn(){
        textField.resignFirstResponder()
        guard let writtenShow = textField.text else {return}
        Task{
            await presenter.soughtShow(show: writtenShow)
            tableView.reloadData()
        }
    }
}

extension SearchViewController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = true
        textField.placeholder = "Search The Show"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let writtenShow = textField.text else {return false}
        if writtenShow == ""{
            print("Lanzar Pop Up")
        }else{
            Task{
                await presenter.soughtShow(show: writtenShow)
                tableView.reloadData()
            }
        }
        return true
    }
}

extension SearchViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showSelected(indexPath: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        print("ESTA ES LA POS\(indexPath.row)")
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

extension SearchViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! SearchTableViewCell
        let model = presenter.viewModel[indexPath.row]
        cell.configure(model: model)
        cell.backgroundColor = UIColor(hex: "#2D2D2A")
        return cell
    }
    
    
}

extension SearchViewController: SoughtUI{
    func updateUI(model: [SearchViewModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

