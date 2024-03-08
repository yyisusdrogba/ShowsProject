//
//  FavoriteInteractor.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 28/02/24.
//

import Foundation
import UIKit

class FavoriteInteractor{
    
    
    var presenter: FavoritePresenter?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getAllItems(){
        do{
            presenter?.models = try context.fetch(FavoriteItems.fetchRequest())
            DispatchQueue.main.async {
            }
        }
        catch{

        }
    }
    
    func createItems(id:String,image:String,name:String){
        let newItem = FavoriteItems(context: context)
        newItem.id = id
        newItem.image = image
        newItem.name = name
        
        do{
            try context.save()
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
    
    func getFavoriteShow(model: FavoriteViewModel){
        let convertIntInString = String(model.id)
        if let presenter = presenter {
            if presenter.models.contains(where: { $0.name == model.name}){
                print("MISMO ID")
            }else{
                createItems(id: convertIntInString, image: model.image, name: model.name)
            }
        }
    }
    
    func deleteFavoriteShow(model:FavoriteItems){
        deleteFavoriteShow(model: model)
    }
    
}
