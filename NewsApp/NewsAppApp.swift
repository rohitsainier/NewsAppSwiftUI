//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Rohit Saini on 07/07/21.
//

import SwiftUI

@main
struct NewsAppApp: App {
    @StateObject var articleBookmarkVM = ArticleBookmarkViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkVM)
        }
    }
}
