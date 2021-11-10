//
//  ArticleManager.swift
//  chpanPW5
//
//  Created by Семён Кондаков on 10.11.2021.
//

import Foundation

class AritcleManager{
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
    var articles: [ArticleModel]?
    
    // MARK: - Fetch news
    private func fetchNews() {
        guard let url = getURL(4, 1) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data,
            response, error in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                var articlePage = try?
                JSONDecoder().decode(ArticlePage.self, from: data)
                articlePage?.passTheRequestId()
                self?.articles = articlePage?.news
            }
        }.resume()
    }
}
