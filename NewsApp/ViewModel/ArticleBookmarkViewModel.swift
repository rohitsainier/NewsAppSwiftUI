//
//  ArticleBookmarkViewModel.swift
//  NewsApp
//
//  Created by Rohit Saini on 09/07/21.
//

import SwiftUI

@MainActor
class ArticleBookmarkViewModel:ObservableObject{
    @Published private(set) var bookmarks:[Article] = []
    private let bookmarkStore = PlistDataStore<[Article]>(filename: "bookmarks")
    
    static let shared = ArticleBookmarkViewModel()
    private init(){
        async{
            await load()
        }
    }
    
    private func load() async{
        bookmarks = await bookmarkStore.load() ?? []
    }
    
    func isBookmark(for article:Article) -> Bool{
        bookmarks.first { article.id == $0.id } != nil
    }
    
    func addBookmark(for article: Article) {
        guard !isBookmark(for: article) else{
            return
        }
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    }
    
    func removeBookmark(for article:Article){
        guard let index = bookmarks.firstIndex(where: {article.id == $0.id} ) else{
            return
        }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    }
    
    private func bookmarkUpdated(){
        let bookmarks = self.bookmarks
        async{
            await bookmarkStore.save(bookmarks)
        }
    }
}
