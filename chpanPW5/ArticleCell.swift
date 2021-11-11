//
//  ArticleCell.swift
//  chpanPW5
//
//  Created by Семён Кондаков on 10.11.2021.
//

import Foundation
import UIKit
import WebKit

class ArticleCell: UITableViewCell{
    
    public var articleModel = ArticleModel()
    
    let titlelabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        control.textAlignment = .center
        control.textColor = UIColor.white
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let announcelabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        control.textAlignment = .left
        control.textColor = UIColor.black
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let imageview: UIImageView = {
        let control = UIImageView()
        return control
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage() -> UIImage? {
        guard let data = try? Data(contentsOf: (articleModel.img?.url)!) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    func setupCell(){
        backgroundColor = UIColor.gray
        DispatchQueue.main.async {
            self.imageview.image = self.loadImage()
        }
        titlelabel.text = articleModel.title
        announcelabel.text = articleModel.announce
        addSubview(titlelabel)
        addSubview(announcelabel)
        titlelabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
        titlelabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        announcelabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 5).isActive = true
        announcelabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        backgroundView = imageview
    }
    
    
}
