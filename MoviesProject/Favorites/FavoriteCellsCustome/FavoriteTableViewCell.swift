//
//  FavoriteTableViewCell.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 28/02/24.
//

import UIKit
import Kingfisher

class FavoriteTableViewCell: UITableViewCell {
    
    let image: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let title: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        addSubview(image)
        addSubview(title)
        
        NSLayoutConstraint.activate([
        
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            image.widthAnchor.constraint(equalToConstant: 150),
            
            title.topAnchor.constraint(equalTo: topAnchor),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor),
            title.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        
        ])
    }
    
    
    
    func configure(model:FavoriteViewModel){
        image.kf.setImage(with: URL(string: model.image))
        title.text = model.name
    }

}
