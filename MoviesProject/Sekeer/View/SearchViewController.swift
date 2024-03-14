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
            .foregroundColor: UIColor.white,
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
        configurateViews()
        view.backgroundColor = UIColor(hex: "#3F5E5A")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func configurateViews(){
        textField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hex: "#3F5E5A")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        view.addSubview(textField)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            textField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
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

