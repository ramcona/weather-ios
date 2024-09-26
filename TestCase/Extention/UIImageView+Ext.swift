//
//  UIImageView+Ext.swift
//  TestCase
//
//  Created by Rafli on 06/06/23.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func makeRounded() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.clipsToBounds = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = ColorConstants.greyOutline.cgColor
    }
    
    func loadImage(fromURLString urlString: String, isCircular: Bool = false) {
        guard let url = URL(string: urlString) else {
            return
        }
        let placeholder: UIImage? = UIImage(named: "ic_menu_jactivity")
        
        let kfOptions: KingfisherOptionsInfo = [
            .transition(.fade(0.2)),
            .backgroundDecode,
            .cacheOriginalImage
        ]
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: kfOptions,
            progressBlock: nil) { [weak self] result in
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        if isCircular {
                            self?.image = value.image.circularImage()
                        }
                    }
                case .failure(let error):
                    print("Error loading image: \(error)")
                    self?.image = placeholder
                }
            }
    }
}
