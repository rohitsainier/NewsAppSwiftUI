//
//  BookmarkTabView.swift
//  NewsApp
//
//  Created by Rohit Saini on 09/07/21.
//

import SwiftUI

struct BookmarkTabView: View {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    @State var searchText:String = ""
    var body: some View {
        let articles = self.articles
        NavigationView{
            ArticleListView(articles: articles)
                .overlay(overlayView(isEmpty: articles.isEmpty))
                .navigationTitle("Saved Articles")
        }
        .searchable(text: $searchText)
    }
    
    private var articles:[Article]{
        if searchText.isEmpty{
            return articleBookmarkVM.bookmarks
        }
        return articleBookmarkVM.bookmarks
            .filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
    }
    
    @ViewBuilder
    func overlayView(isEmpty:Bool) -> some View{
        if isEmpty{
            EmptyPlaceholderView(text: "No Saved Articles", image: Image(systemName: "bookmark"))
        }
    }
}

//struct BookmarkTabView_Previews: PreviewProvider {
//    @StateObject static var articleBookmarkVM = ArticleBookmarkViewModel()
//    static var previews: some View {
//        BookmarkTabView()
//            .environmentObject(articleBookmarkVM)
//    }
//}



