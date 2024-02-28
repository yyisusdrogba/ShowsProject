//
//  ShowsTableViewCell.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 02/02/24.
//

import UIKit
import Kingfisher

class ShowsTableViewCell: UITableViewCell {

    var showImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var showName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 2
        name.textColor = UIColor(hex: "#ffffff")
        name.font = .boldSystemFont(ofSize: 18)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let showSummary: UILabel = {
      let summary = UILabel()
        summary.numberOfLines = 6
        summary.textColor = UIColor(hex: "#ffffff")
        summary.font = .systemFont(ofSize: 14)
        summary.translatesAutoresizingMaskIntoConstraints = false
        summary.lineBreakMode = .byCharWrapping
        return summary
    }()
    
    let showScore: UILabel = {
       let score = UILabel()
        score.numberOfLines = 1
        score.textColor = UIColor(hex: "#ffffff")
        score.font = .systemFont(ofSize: 10)
        score.translatesAutoresizingMaskIntoConstraints = false
        return score
    }()
    
    let showImgScore: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "star.fill"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(hex: "#20FC8F")
        return image
    }()
    
    let showlanguaje: UILabel = {
        let languaje = UILabel()
        languaje.numberOfLines = 1
        languaje.textColor = UIColor(hex: "#ffffff")
        languaje.font = .boldSystemFont(ofSize: 10)
        languaje.translatesAutoresizingMaskIntoConstraints =  false
        return languaje
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        addSubview(showImage)
        addSubview(showName)
        addSubview(showSummary)
        addSubview(showlanguaje)
        addSubview(showImgScore)
        addSubview(showScore)
        
        NSLayoutConstraint.activate([
        
            showImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            showImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            showImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            showImage.heightAnchor.constraint(equalToConstant: 200),
            showImage.widthAnchor.constraint(equalToConstant: 150),
            
            showName.leadingAnchor.constraint(equalTo: showImage.trailingAnchor, constant: 2),
            showName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            showName.topAnchor.constraint(equalTo: showImage.topAnchor, constant: 2),
            
            showSummary.topAnchor.constraint(equalTo: showName.bottomAnchor, constant: 8),
            showSummary.leadingAnchor.constraint(equalTo: showImage.trailingAnchor, constant: 2),
            showSummary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            showlanguaje.topAnchor.constraint(equalTo: showSummary.bottomAnchor, constant: 10),
            showlanguaje.leadingAnchor.constraint(equalTo: showImage.trailingAnchor, constant: 2),
            showlanguaje.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 2),
            
            showImgScore.trailingAnchor.constraint(equalTo: showScore.leadingAnchor, constant: -4),
            showImgScore.topAnchor.constraint(equalTo: showlanguaje.bottomAnchor, constant: 2),
            showImgScore.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            showImgScore.heightAnchor.constraint(equalToConstant: 30),
            showImgScore.widthAnchor.constraint(equalToConstant: 20),
            
            showScore.topAnchor.constraint(equalTo: showlanguaje.bottomAnchor, constant: 2),
            showScore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            showScore.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
            
        ])
    }
    
    func configure(model: ShowViewModel){
        
        guard let emptyScore = model.score else {return}
        
        showImage.kf.setImage(with: URL(string: model.image))
        showName.text = model.name
        showSummary.text = model.summary.removeHTMLTags()
        showlanguaje.text = model.languaje
        showScore.text = String(describing: emptyScore)
    }
    
}
