//
//  CharacterCollectionCell.swift
//  ios-view-code
//
//  Created by Danilo Pena on 28/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

final class CharacterCollectionCell: UICollectionViewCell {
    
    // Mark: - Variables and Lets
    private let imageCache = NSCache<AnyObject, UIImage>()
    private var imageChar = UIImageView()
    private let status = UILabel()
    private let name = UILabel()
    private var imageURL: URL?

    // Mark: - Father class methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Mark: - Support Methods
    func setupView() {
        imageChar.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: 140)
        
        contentView.addSubview(imageChar)
        contentView.addSubview(status)
        contentView.addSubview(name)
        
        let marginsStatus = imageChar.layoutMarginsGuide
        status.translatesAutoresizingMaskIntoConstraints = false
        status.leadingAnchor.constraint(equalTo: marginsStatus.leadingAnchor,
                                        constant: 10).isActive = true
        status.trailingAnchor.constraint(equalTo: marginsStatus.trailingAnchor,
                                         constant: 10).isActive = true
        status.topAnchor.constraint(equalTo: marginsStatus.bottomAnchor,
                                    constant: 16).isActive = true
        
        let marginsName = status.layoutMarginsGuide
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: marginsStatus.leadingAnchor,
                                      constant: 10).isActive = true
        name.trailingAnchor.constraint(equalTo: marginsStatus.trailingAnchor,
                                       constant: 10).isActive = true
        name.topAnchor.constraint(equalTo: marginsName.bottomAnchor,
                                  constant: 10).isActive = true
    }
    
    func applyCornerInCell() {
        layer.cornerRadius = 8
        layer.borderColor = Colors.basic?.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
    }
    
    func applyStyleAndTexts(char: CharacterRickAndMorty) {
        applyCornerInCell()
        
        guard let nameStr = char.name,
            let statusStr = char.status,
            let imageStr = char.image else {
                return
        }
        
        name.text = nameStr
        name.textColor = .black
        
        status.text = statusStr
        status.textColor = Colors.graybase_Gray1
        
        if let url = URL(string: imageStr) {
            downloadImage(url: url)
        }
    }
    
    func downloadImage(url: URL) {
        imageURL = url
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) {
            imageChar.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    self.imageChar.image = #imageLiteral(resourceName: "ic-tab-chars")
                    return
                }

                DispatchQueue.main.async(execute: {
                    if let unwrappedData = data,
                       let imageToCache = UIImage(data: unwrappedData) {
                        if self.imageURL == url {
                            self.imageChar.image = imageToCache
                        }
                        self.imageCache.setObject(imageToCache, forKey: url as AnyObject)
                    }
                })
            }).resume()
        }
    }
}
