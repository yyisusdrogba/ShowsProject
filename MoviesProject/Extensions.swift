//
//  Extensions.swift
//  MoviesProject
//
//  Created by Jesus Gonzalez on 06/02/24.
//

import Foundation
import UIKit

extension String{
    
    func removeHTMLTags() -> String{
        guard let data = self.data(using: .utf8) else {return self}
        
        do{
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType:NSAttributedString.DocumentType.html], documentAttributes: nil)
            return attributedString.string
        }catch{
            print("Error al convertir el String")
            return self
        }
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
