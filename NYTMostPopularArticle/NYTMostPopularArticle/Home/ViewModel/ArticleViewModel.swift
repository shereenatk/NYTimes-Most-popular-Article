//
//  ArticleViewModel.swift
//  NYTimes
//
//  Created by ios on 22/03/2024.
//

import Foundation
class ArticleViewModel: ObservableObject {
    
    var urlSession: URLSession
    
    @Published var articleList: [ArticleInfo] = []
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchArticles() {
        guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(AppConstants.apiKey)") else {
            print("Invalid URL")
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(ArticleModel.self, from: data)
                DispatchQueue.main.async {
                    self.articleList = result.results.map {
                        ArticleInfo(id: $0.id, title: $0.title,section: $0.section, subsection: $0.subsection, byline: $0.byline, published_date: $0.published_date, abstract: $0.abstract, url: $0.url, updated: $0.updated, media: $0.media, adx_keywords: $0.adx_keywords)
                    }
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
