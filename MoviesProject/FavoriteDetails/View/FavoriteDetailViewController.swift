//
//  FavoriteDetailViewController.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 04/03/24.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    let activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor(hex: "#20FC8F")
        return activityIndicator
    }()
    
    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#ffffff")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 100
        image.layer.masksToBounds = true
        return image
    }()
    
    let score: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#ffffff")
        return label
    }()
        
    let summary: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 20
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#ffffff")
        return label
    }()
    
    let network: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#ffffff")
        return label
    }()
    
    let uiViewEpisodes: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#20FC8F")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let uiViewCast: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#20FC8F")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let episodes: UILabel = {
        let label = UILabel()
        label.text = "Episodes"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hex: "#2D2D2A")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let site: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("officialSite", for: .normal)
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)
//        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let detailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 220, height: 380)
        layout.minimumLineSpacing = 12
//        layout.headerReferenceSize = .init(width: 20, height: 20)
        //        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let cast: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor(hex: "#2D2D2A")
        return label
    }()
    
    let detailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CastTableViewCell.self, forCellReuseIdentifier: "CastTableViewCell")
//        tableView.backgroundColor = .orange
        return tableView
    }()
  
    var presenter: FavoriteDetailPresenter
    
    init(presenter: FavoriteDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        view.backgroundColor = UIColor(hex: "#2D2D2A")
        detailsCollectionView.register(EpisodesCollectionViewCell.self, forCellWithReuseIdentifier: "EpisodesCollectionViewCell")
        detailsCollectionView.backgroundColor = UIColor(hex: "#2D2D2A")
        detailsTableView.backgroundColor = UIColor(hex: "#2D2D2A")
        detailsCollectionView.dataSource = self
        detailsTableView.dataSource = self
        
        Task{
            await presenter.updateUI()
        }
        view.addSubview(scroll)
        view.addSubview(activityIndicator)
        scroll.addSubview(name)
        scroll.addSubview(image)
        scroll.addSubview(score)
        scroll.addSubview(summary)
        scroll.addSubview(network)
        scroll.addSubview(site)
        scroll.addSubview(uiViewEpisodes)
        scroll.addSubview(detailsCollectionView)
        scroll.addSubview(uiViewCast)
        scroll.addSubview(detailsTableView)
        uiViewEpisodes.addSubview(episodes)
        uiViewCast.addSubview(cast)
        
        NSLayoutConstraint.activate([
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            scroll.topAnchor.constraint(equalTo: view.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            name.topAnchor.constraint(equalTo: scroll.topAnchor,constant: 10),
            name.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
             
            image.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 4),
            image.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            
            score.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 8),
            score.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            score.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            
            summary.topAnchor.constraint(equalTo: score.bottomAnchor,constant: 4),
            summary.leadingAnchor.constraint(equalTo: scroll.leadingAnchor,constant: 12),
            summary.trailingAnchor.constraint(equalTo: scroll.trailingAnchor,constant: -12),
            
            network.topAnchor.constraint(equalTo: summary.bottomAnchor,constant: -6),
            network.leadingAnchor.constraint(equalTo: scroll.leadingAnchor,constant: 12),
            network.trailingAnchor.constraint(equalTo: site.leadingAnchor),
            
            site.topAnchor.constraint(equalTo: summary.bottomAnchor),
            site.leadingAnchor.constraint(equalTo: network.trailingAnchor),
            site.bottomAnchor.constraint(equalTo: episodes.topAnchor,constant: -20),
            
            uiViewEpisodes.topAnchor.constraint(equalTo: network.bottomAnchor),
            uiViewEpisodes.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            uiViewEpisodes.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            uiViewEpisodes.heightAnchor.constraint(equalToConstant: 50),
            
            episodes.centerXAnchor.constraint(equalTo: uiViewEpisodes.centerXAnchor),
            episodes.centerYAnchor.constraint(equalTo: uiViewEpisodes.centerYAnchor),
            
            detailsCollectionView.topAnchor.constraint(equalTo: uiViewEpisodes.bottomAnchor,constant: 20),
            detailsCollectionView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            detailsCollectionView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            detailsCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            detailsCollectionView.heightAnchor.constraint(equalToConstant: 790),
            
            uiViewCast.topAnchor.constraint(equalTo: detailsCollectionView.bottomAnchor,constant: 20),
            uiViewCast.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            uiViewCast.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            uiViewCast.heightAnchor.constraint(equalToConstant: 50),
            
            cast.centerXAnchor.constraint(equalTo: uiViewCast.centerXAnchor),
            cast.centerYAnchor.constraint(equalTo: uiViewCast.centerYAnchor),
            
            detailsTableView.topAnchor.constraint(equalTo: uiViewCast.bottomAnchor),
            detailsTableView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            detailsTableView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor),
            detailsTableView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor),
            detailsTableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            detailsTableView.heightAnchor.constraint(equalToConstant: 500)
            
        ])
    }
    
    @objc func openLink() {
        let officialSiteURL = presenter.details.site
        guard let url = URL(string: officialSiteURL!) else {
            return
        }
        UIApplication.shared.open(url)
    }

}

extension FavoriteDetailViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpisodesCollectionViewCell", for: indexPath) as! EpisodesCollectionViewCell
        let episodesModel = presenter.episodes[indexPath.row]
        cell.configure(model: episodesModel)
        cell.backgroundColor = UIColor(hex: "#3F5E5A")
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        return cell
    }
}

extension FavoriteDetailViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastTableViewCell", for: indexPath) as! CastTableViewCell
        let model = presenter.cast[indexPath.row]
        cell.configure(model: model)
        return cell
    }
}

extension FavoriteDetailViewController:DetailsUI{
    
    func getDetail(details: DetailsViewModel) {
        DispatchQueue.main.async {
            self.name.text = details.name
            self.score.text = String("Score:\(details.ratingScore!)")
            self.network.text = "\(details.network!):"
            self.image.kf.setImage(with: URL(string: details.image!))
            self.summary.text = details.summary!.removeHTMLTags()
            self.activityIndicator.isHidden = true

        }
    }
    
    func getEpisodes(episodes: [EpisodesViewModel]) {
        DispatchQueue.main.async {
            self.detailsCollectionView.reloadData()
            self.activityIndicator.isHidden = true
        }
    }
    
    func getCast(cast: [CastViewModel]) {
        DispatchQueue.main.async {
            self.detailsTableView.reloadData()
            self.activityIndicator.isHidden = true
        }
    }
}


