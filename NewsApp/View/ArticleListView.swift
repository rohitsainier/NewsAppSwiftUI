//
//  ArticleListView.swift
//  NewsApp
//
//  Created by Rohit Saini on 08/07/21.
//

import SwiftUI

struct ArticleListView: View {
    let articles: [Article]
    var body: some View {
        NavigationView{
            List{
                ForEach(articles){article in
                    ArticleRowView(article: article)
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
            .navigationTitle("Articles")
        }
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView(articles: Article.previewData)
    }
}
