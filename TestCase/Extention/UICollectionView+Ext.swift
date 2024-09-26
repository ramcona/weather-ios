//
//  UICollectionView+Ext.swift
//  TestCase
//
//  Created by Rafli on 12/06/23.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func setEmptyView(image: UIImage, title: String) {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emptyView.addSubview(imageView)
        emptyView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -40),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -16)
        ])
        
        self.backgroundView = emptyView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
