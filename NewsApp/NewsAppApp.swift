//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Rohit Saini on 07/07/21.
//

import SwiftUI

@main
struct NewsAppApp: App {
    var body: some Scene {
        WindowGroup {
            ArticleListView(articles: Article.previewData)
        }
    }
}
