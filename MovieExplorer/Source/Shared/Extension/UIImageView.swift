//
//  File.swift
//  MovieExplorer
//
//  Created by Diab on 01/09/2025.
//


import UIKit.UIImageView
import Kingfisher

extension UIImageView {
    func setWith(_ stringURL: String?) {
        self.kf.indicatorType = .activity
        guard let stringURL, let url = URL(string: stringURL) else {
             return
        }
        self.kf.setImage(
            with: url,
            options: [
                .transition(.fade(0.4)),
                .processor(DownsamplingImageProcessor(size: .init(width: 100, height: 100))),
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        )
    }
}
