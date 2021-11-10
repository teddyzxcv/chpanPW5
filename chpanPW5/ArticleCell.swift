//
//  ArticleCell.swift
//  chpanPW5
//
//  Created by Семён Кондаков on 10.11.2021.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell{
    
    public let articleModel = ArticleModel()
    
    let titlelabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        control.textAlignment = .center
        control.textColor = UIColor.black
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let announcelabel: UILabel = {
        let control = UILabel()
        control.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        control.textAlignment = .left
        control.textColor = UIColor.gray
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    let imageview: UIImageView = {
        let control = UIImageView()
        return control
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage() -> UIImage? {
        guard let data = try? Data(contentsOf: articleModel.img?.url) else {
            return nil
        }
        return UIImage(data: data)
    }
}
