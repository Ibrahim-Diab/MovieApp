//
//  MovieCollectionViewCell.swift
//  MovieExplorer
//
//  Created by Diab on 1/09/2025.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var favouriteIcon: UIImageView!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var favButton: UIButton!


    var favAction: ((_ id: Int)-> Void)?
    
    private var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 8.0
        
    }
    
    
    func configCell(with movie: MovieCellDataSource){
        self.id = movie.id
        movieImageView.setWith(movie.posterURL)
        movieTitleLabel.text = movie.title
        let favIcon = movie.isMovieFavourite ? "fav_icon" : "unFav_icon"
        favouriteIcon.image = UIImage(named: favIcon)
    }
    
    
    @IBAction private func favWasPressed(_ sender: UIButton){
        guard let id = id else {return}
        favAction?(id)
    }
}
