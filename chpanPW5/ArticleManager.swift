//
//  ArticleManager.swift
//  chpanPW5
//
//  Created by Семён Кондаков on 10.11.2021.
//

import Foundation

class ArticleManager{
    private func getURL(_ rubric: Int, _ pageIndex: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)")
    }
    public var articles: [ArticleModel]?
    
    // MARK: - Fetch news
    private func fetchNews() {
        let sem = DispatchSemaphore.init(value: 0)
        guard let url = getURL(4, 1) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data,
            response, error in
            defer { sem.signal() }
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                var articlePage = try?
                JSONDecoder().decode(ArticlePage.self, from: data)
                articlePage?.passTheRequestId()
                self?.articles = articlePage?.news
                print("1234")
            }
        }
        task.resume()
        sem.wait()
    }
    
    public func setupArticles(){
        fetchNews()
    }
}
