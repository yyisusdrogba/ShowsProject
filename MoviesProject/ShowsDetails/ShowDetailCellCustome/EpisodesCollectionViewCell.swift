//
//  EpisodesCollectionViewCell.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 12/02/24.
//

import UIKit
import Kingfisher

class EpisodesCollectionViewCell: UICollectionViewCell {
        
    let title: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 3
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#ffffff")
        return label
    }()
    
    let image: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let summary: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#ffffff")
        return label
    }()
    
    let season: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#ffffff")
        return label
    }()
    
    let episode: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#ffffff")
        return label
    }()
    
    let rating: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#ffffff")
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        addSubview(title)
        addSubview(image)
        addSubview(summary)
        addSubview(season)
        addSubview(episode)
        addSubview(rating)
        
        NSLayoutConstraint.activate([

            title.topAnchor.constraint(equalTo: topAnchor,constant: 0),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            image.widthAnchor.constraint(equalToConstant: 380),
            image.heightAnchor.constraint(equalToConstant: 140),
            
            summary.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 4),
            summary.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            summary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            
            season.topAnchor.constraint(equalTo: summary.bottomAnchor,constant: 20),
            season.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            season.trailingAnchor.constraint(equalTo: episode.leadingAnchor, constant: -20),
            
            episode.topAnchor.constraint(equalTo: summary.bottomAnchor, constant: 20),
            episode.leadingAnchor.constraint(equalTo: season.trailingAnchor, constant: 0),
            episode.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            
            rating.topAnchor.constraint(equalTo: season.bottomAnchor, constant: 5),
            rating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            rating.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            
        ])
    }
    
    func configure(model: EpisodesViewModel){
        title.text = model.name
        image.kf.setImage(with: URL(string: model.image!))
        summary.text = model.summary!.removeHTMLTags()
        season.text = "Season:\(model.season!)"
        episode.text = "Episode: \(model.episodeNumber!)"
        rating.text = String("Score: \(model.rating!)" )
    }
    
}
