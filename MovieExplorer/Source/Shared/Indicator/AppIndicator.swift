//
//  AppIndicator.swift
//
//  Created by Diab®
//

import UIKit

class AppIndicator {
    
    // MARK: - properties -
    
    private let indicatorContainer: UIView  = UIView()
    private let indicatorView: UIView = UIView()
    private let indicatorImageView: UIImageView = UIImageView()
    private let length: CGFloat = UIScreen.main.bounds.width * 0.2
    private let innerLength: CGFloat = UIScreen.main.bounds.width * 0.2
    private let tag: Int = 19920301
    
    static let shared: AppIndicator = AppIndicator()
    
    // MARK: - Initializer -
    
    private init() {}
    
    // MARK: - Private Methods -
    
    private func handleInitialView() {
        
        self.indicatorContainer.tag = self.tag
        self.indicatorContainer.alpha = 0
        self.indicatorContainer.backgroundColor = .black.withAlphaComponent(0.2)
        self.indicatorView.backgroundColor = .white
        self.indicatorImageView.contentMode = .scaleAspectFit
        self.indicatorImageView.image = UIImage.gifImageWithName("LottieAnimationGIF")
        self.indicatorView.layer.cornerRadius = 15
        self.indicatorView.clipsToBounds = true
        
        self.indicatorView.addSubview(self.indicatorImageView)
        self.indicatorContainer.addSubview(self.indicatorView)
        let window = UIApplication.shared.keyWindow
        guard let window = window else {return}
        window.addSubview(self.indicatorContainer)
        
        //MARK:- Add constraints
        self.indicatorContainer.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.indicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.indicatorContainer.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        self.indicatorContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        self.indicatorView.heightAnchor.constraint(equalToConstant: self.length).isActive = true
        self.indicatorView.widthAnchor.constraint(equalToConstant: self.length).isActive = true
        self.indicatorView.centerYAnchor.constraint(equalTo: self.indicatorContainer.centerYAnchor).isActive = true
        self.indicatorView.centerXAnchor.constraint(equalTo: self.indicatorContainer.centerXAnchor).isActive = true
        
        self.indicatorImageView.heightAnchor.constraint(equalToConstant: self.innerLength).isActive = true
        self.indicatorImageView.widthAnchor.constraint(equalToConstant: self.innerLength).isActive = true
        self.indicatorImageView.centerYAnchor.constraint(equalTo: self.indicatorView.centerYAnchor).isActive = true
        self.indicatorImageView.centerXAnchor.constraint(equalTo: self.indicatorView.centerXAnchor).isActive = true

    }
    
    // MARK: - Action Methods -
    
    func show(isGif: Bool) {
        self.handleInitialView()
        UIView.animate(withDuration: 0.1) {
            self.indicatorContainer.alpha = 1
        }
    }
    
    func dismiss() {
        let window = UIApplication.shared.keyWindow
        guard let window = window else {return}
        UIView.animate(withDuration: 0.2) {
            window.viewWithTag(self.tag)?.alpha = 0
        } completion: { _ in
            window.viewWithTag(self.tag)?.removeFromSuperview()
        }
    }
}
