//
//  ArticleManager.swift
//  chpanPW5
//
//  Created by Семён Кондаков on 10.11.2021.
//

import Foundation

class ArticleManager{
    
    
    var delegate : UpdatesDelegate?
    
    private func getURL(_ rubric: Int, _ pageIndex: Int, _ pagesize: Int) -> URL? {
        URL(string: "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=\(pagesize)&pageIndex=\(pageIndex)")
    }
    public var articles: [ArticleModel]?{
        didSet {
            self.delegate?.didUpdated(finished: true)
        }
    }
    
    // MARK: - Fetch news
    private func fetchNews() {
        guard let url = getURL(10, 12, 16) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data,
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
        }
        task.resume()
    }
    
    public func setupArticles(){
        fetchNews()
    }
}
