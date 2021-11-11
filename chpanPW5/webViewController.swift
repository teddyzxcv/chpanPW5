//
//  webViewController.swift
//  chpanPW5
//
//  Created by Семён Кондаков on 11.11.2021.
//

import Foundation
import WebKit

class webViewController: UIViewController, WKNavigationDelegate{
    var webView = WKWebView()
    
    var url: URL?
    
    override func viewDidLoad() {
        webView.load(URLRequest(url: url!))
        view.addSubview(webView)
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinRight(to: view)
        webView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        webView.pinLeft(to: view)
    }
}
