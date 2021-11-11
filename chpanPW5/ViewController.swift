//
//  ViewController.swift
//  chpanPW5
//
//  Created by Семён Кондаков on 10.11.2021.
//

import UIKit

class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView!
    let cellId = "ArticleCell"
    var articleManager = ArticleManager()
    var articles: [ArticleModel]?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleManager.articles?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticleCell
        cell?.articleModel = articleManager.articles?[indexPath.row] ?? ArticleModel()
        cell?.setupCell()
        cell?.layer.cornerRadius  = 20
        cell?.layer.masksToBounds = true
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleManager.setupArticles()
        view.backgroundColor = UIColor.darkGray
        setupArticleView()
        // Do any additional setup after loading the view.
    }
    
    private func setupArticleView(){
        let rect = CGRect(x: 15, y: 15, width: view.frame.width - 30, height: view.frame.height - 30)
        
        tableView = UITableView(frame: rect)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 160
        tableView.showsVerticalScrollIndicator = true
        tableView.translatesAutoresizingMaskIntoConstraints = false //
        tableView.layer.cornerRadius = 35
        tableView.layer.masksToBounds = true
        
        self.view.addSubview(tableView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.alwaysBounceVertical = true
    }
}

