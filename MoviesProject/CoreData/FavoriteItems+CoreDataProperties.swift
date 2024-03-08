//
//  FavoriteItems+CoreDataProperties.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 06/03/24.
//
//

import Foundation
import CoreData


extension FavoriteItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteItems> {
        return NSFetchRequest<FavoriteItems>(entityName: "FavoriteItems")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?

}

extension FavoriteItems : Identifiable {

}
