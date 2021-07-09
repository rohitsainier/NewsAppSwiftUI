//
//  Category.swift
//  NewsApp
//
//  Created by Rohit Saini on 09/07/21.
//

import Foundation

enum Category:String,CaseIterable{
    case general
    case business
    case technology
    case entertainment
    case sports
    case sceince
    case health
    
    var text:String{
        if self == .general{
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}

extension Category:Identifiable{
    var id: Self { self }
}
