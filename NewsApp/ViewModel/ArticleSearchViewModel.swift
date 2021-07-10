//
//  ArticleSearchViewModel.swift
//  NewsApp
//
//  Created by Rohit Saini on 10/07/21.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel:ObservableObject{
    @Published var phase:DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    private var newsAPI = NewsAPI.shared
    
    func searchArticles() async{
        let searchQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        if searchQuery.isEmpty{
            return
        }
        do{
            let articles = try await newsAPI.search(for: searchQuery)
            phase = .success(articles)
        }
        catch{
            phase = .failure(error)
        }
    }
}
