//
//  CastTableViewCell.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 12/02/24.
//

import UIKit
import Kingfisher

class CastTableViewCell: UITableViewCell {
    
    let viewPerson: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor =  UIColor(hex: "#353831")
        return view
    }()
    
    let viewCharacter: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#3F5E5A")
        return view
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 3
        label.textColor = UIColor(hex: "#ffffff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageProfile: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let country: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = UIColor(hex: "#ffffff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let character: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 3
        label.textColor = UIColor(hex: "#ffffff")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let characterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        viewPerson.addSubview(imageProfile)
        viewPerson.addSubview(name)
        viewPerson.addSubview(country)
        viewCharacter.addSubview(characterImage)
        viewCharacter.addSubview(character)
        addSubview(viewPerson)
        addSubview(viewCharacter)
        
        NSLayoutConstraint.activate([
                    
            viewPerson.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewPerson.topAnchor.constraint(equalTo: topAnchor),
            viewPerson.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewPerson.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            viewCharacter.topAnchor.constraint(equalTo: topAnchor),
            viewCharacter.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewCharacter.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewCharacter.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            imageProfile.topAnchor.constraint(equalTo: viewPerson.topAnchor),
            imageProfile.leadingAnchor.constraint(equalTo: viewPerson.leadingAnchor),
            imageProfile.bottomAnchor.constraint(equalTo: viewPerson.bottomAnchor),
            imageProfile.heightAnchor.constraint(equalToConstant: 140),
            imageProfile.widthAnchor.constraint(equalToConstant: 100),
            
            name.topAnchor.constraint(equalTo: viewPerson.topAnchor,constant: 50),
            name.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor,constant: 4),
            name.trailingAnchor.constraint(equalTo: viewPerson.trailingAnchor,constant: -4),
            
            country.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 6),
            country.leadingAnchor.constraint(equalTo: imageProfile.trailingAnchor,constant: 4),
            country.trailingAnchor.constraint(equalTo: viewPerson.trailingAnchor),
            
            characterImage.topAnchor.constraint(equalTo: viewCharacter.topAnchor),
            characterImage.leadingAnchor.constraint(equalTo: viewCharacter.leadingAnchor),
            characterImage.bottomAnchor.constraint(equalTo: viewCharacter.bottomAnchor),
            characterImage.heightAnchor.constraint(equalToConstant: 140),
            characterImage.widthAnchor.constraint(equalToConstant: 100),
            
            character.topAnchor.constraint(equalTo: viewCharacter.topAnchor,constant: 50),
            character.leadingAnchor.constraint(equalTo: characterImage.trailingAnchor,constant: 4),
            character.trailingAnchor.constraint(equalTo: viewCharacter.trailingAnchor,constant: -4),
            
        ])
    }
    
    func configure(model: CastViewModel){
        imageProfile.kf.setImage(with: URL(string: model.image!))
        name.text = model.name
        country.text = model.country
        character.text = model.character
        characterImage.kf.setImage(with: URL(string: model.characterImage!))
    }
    
}
