//
//  ArticleNewsViewModel.swift
//  NewsApp
//
//  Created by Rohit Saini on 09/07/21.
//

import SwiftUI

enum DataFetchPhase<T>{
    case empty
    case success(T)
    case failure(Error)
}


@MainActor
class ArticleNewsViewModel:ObservableObject{
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var selectedCategory:Category
    private let newAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil,selectedCategory:Category = .general){
        if let articles = articles{
            self.phase = .success(articles)
        }
        else{
            self.phase = .empty
        }
        self.selectedCategory = selectedCategory
    }
    
    func loadArticles() async{
        phase = .empty
        do{
            let articles = try await newAPI.fetch(from: selectedCategory)
            phase = .success(articles)
        }
        catch{
            phase = .failure(error)
        }
    }
}
