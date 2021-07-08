//
//  NewsApiResponse.swift
//  NewsApp
//
//  Created by Rohit Saini on 07/07/21.
//

import Foundation

struct NewsApiResponse:Decodable{
    let status:String
    let totalResults:Int?
    let articles:[Article]?
    
    let code:String?
    let message:String?
}
