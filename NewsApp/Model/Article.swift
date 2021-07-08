//
//  Article.swift
//  NewsApp
//
//  Created by Rohit Saini on 07/07/21.
//

import Foundation

fileprivate let relativeDateFormatter = RelativeDateTimeFormatter()

struct Article{
    let source: Source
    let title:String
    let url:String
    let publishedAt:Date
    
    let author:String?
    let description:String?
    let urlToImage:String?
    
    var authorText:String{
        author ?? ""
    }
    var descriptionText:String{
        description ?? ""
    }
    var captionText:String{
        "\(source.name) ﹒ \(relativeDateFormatter.localizedString(for: publishedAt,relativeTo:Date()))"
    }
    var articleURL:URL{
        URL(string: url)!
    }
    var imageURL:URL?{
        guard let urlToImage = urlToImage else {
            return nil
        }
        return URL(string: urlToImage)
    }
    
}

extension Article:Codable{}
extension Article:Equatable{}
extension Article:Identifiable{
    var id:String {url}
}
extension Article{
    static var previewData:[Article]{
        let previewDataUrl = Bundle.main.url(forResource: "news", withExtension: "json")!
        let data = try! Data(contentsOf: previewDataUrl)
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        let apiResponse = try! jsonDecoder.decode(NewsApiResponse.self, from: data)
        return apiResponse.articles ?? []
    }
}



struct Source{
    let name:String
}

extension Source:Codable{}
extension Source:Equatable{}
