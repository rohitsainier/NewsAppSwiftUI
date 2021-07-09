//
//  BookmarkTabView.swift
//  NewsApp
//
//  Created by Rohit Saini on 09/07/21.
//

import SwiftUI

struct BookmarkTabView: View {
    @EnvironmentObject var articleBookmarkVM: ArticleBookmarkViewModel
    var body: some View {
        NavigationView{
            ArticleListView(articles: articleBookmarkVM.bookmarks)
                .overlay(overlayView(isEmpty: articleBookmarkVM.bookmarks.isEmpty))
                .navigationTitle("Saved Articles")
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



