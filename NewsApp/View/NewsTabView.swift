//
//  NewsTabView.swift
//  NewsApp
//
//  Created by Rohit Saini on 09/07/21.
//

import SwiftUI

struct NewsTabView: View {
    @StateObject var articleNewsVM = ArticleNewsViewModel()
    var body: some View {
        NavigationView{
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .refreshable {
                    loadTask()
                }
                .onAppear{
                    loadTask()
                }
                .navigationTitle(articleNewsVM.selectedCategory.text)
        }
    }
    
    private var articles:[Article]{
        if case let .success(articles) = articleNewsVM.phase{
            return articles
        }
        else{
            return []
        }
    }
    
    private func loadTask(){
        async{
            await articleNewsVM.loadArticles()
        }
    }
    
    @ViewBuilder
    private var overlayView: some View{
        switch articleNewsVM.phase{
        case .empty :
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyPlaceholderView(text: "No Article Found!", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription) {
                loadTask()
            }
        default: EmptyView()
        }
    }
}

struct NewsTabView_Previews: PreviewProvider {
    static var previews: some View {
        NewsTabView(articleNewsVM: ArticleNewsViewModel(articles: Article.previewData))
    }
}
