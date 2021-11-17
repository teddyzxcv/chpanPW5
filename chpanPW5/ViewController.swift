//
//  ViewController.swift
//  chpanPW5
//
//  Created by Семён Кондаков on 10.11.2021.
//

import UIKit
import WebKit

class ArticleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UpdatesDelegate {
    
    var window: UIWindow?
    private var tableView: UITableView!{
        didSet {
            // Configure Table View
            tableView.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    let cellId = "ArticleCell"
    var articleManager = ArticleManager()
    
    private var articles: [ArticleModel] = []{
        didSet{
            DispatchQueue.main.async{ [self] in
                tableView.reloadData()
                tableView.isHidden = articles.isEmpty
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? ArticleCell
        cell?.articleModel = articles[indexPath.row]
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
        articleManager.delegate = self
        articleManager.setupArticles()
        view.backgroundColor = UIColor.darkGray
        setupArticleView()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = articles[indexPath.row].articleUrl {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let nav1 = UINavigationController()
            let vc = webViewController()
            vc.url = url
            nav1.viewControllers = [vc]
            self.window!.rootViewController = nav1
            self.window?.makeKeyAndVisible()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setupArticleView(){
        let rect = CGRect(x: 15, y: 15, width: view.frame.width - 30, height: view.frame.height - 30)
        
        tableView = UITableView(frame: rect)
        tableView.register(ArticleCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = UIColor.clear
        tableView.rowHeight = 200
        tableView.showsVerticalScrollIndicator = true
        tableView.translatesAutoresizingMaskIntoConstraints = false //
        tableView.layer.cornerRadius = 20
        tableView.layer.masksToBounds = true
        
        self.view.addSubview(tableView)
    }
    
    private func handleMarkAsShare(index: IndexPath) {
        if let url = articles[index.row].articleUrl{
            var urlToShare = [Any]()
            urlToShare.append(url)
            let activityviewcontroller = UIActivityViewController(activityItems:urlToShare,applicationActivities: nil)
            self.present(activityviewcontroller, animated: true, completion: nil)
        }
        print("Share")
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Share") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsShare(index: indexPath)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Share") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsShare(index: indexPath)
                                            completionHandler(true)
        }
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.alwaysBounceVertical = true
    }
    
    func didUpdated(finished: Bool) {
        guard finished else {
            // Handle the unfinished state
            return
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        articles = articleManager.articles ?? []
    }
    
}


