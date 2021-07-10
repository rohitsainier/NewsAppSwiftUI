//
//  SearchTabView.swift
//  NewsApp
//
//  Created by Rohit Saini on 10/07/21.
//

import SwiftUI

struct SearchTabView: View {
    @StateObject var searchVM = ArticleSearchViewModel()
    let suggestionArr:[String] = ["Apple","BTC","Covid19","iOS 15","Narender Modi","Punjab"]
    var body: some View {
        NavigationView{
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .navigationTitle("Search")
                
        }
        .searchable(text: $searchVM.searchQuery){suggestionView}
        .onChange(of: searchVM.searchQuery){ newValue in
            if newValue.isEmpty{
                searchVM.phase = .empty
            }
        }
        .onSubmit(of: .search, search)
    }
    
    private var articles:[Article]{
        if case let .success(articles) = searchVM.phase{
            return articles
        }
        else{
            return []
        }
    }
    
    @ViewBuilder
    private var overlayView: some View{
        switch searchVM.phase{
        case .empty :
            if !searchVM.searchQuery.isEmpty{
                ProgressView()
            }
            else{
                EmptyPlaceholderView(text: "Type your query to search for news", image: Image(systemName: "magnifyingglass"))
            }
           
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No search result found!", image: Image(systemName: "magnifyingglass"))
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
        default: EmptyView()
        }
    }
    
    @ViewBuilder
    private var suggestionView: some View{
        ForEach(suggestionArr,id:\.self){ text in
            Button {
                searchVM.searchQuery = text
            } label: {
                Text(text)
            }

        }
    }
    private func search(){
        async{
            await searchVM.searchArticles()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTabView()
    }
}
