//
//  MovieItemCollectionViewCell.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import UIKit
import Kingfisher

class MovieItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapView: UIView!
    @IBOutlet weak var wrapTitleView: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        wrapTitleView.backgroundColor = .clear
        wrapView.layer.cornerRadius = 6;
    }

    func displayData(movie: MovieModel) {
        let image = UIImage(named: "image_placeholder")
        imgMovie.kf.setImage(with: movie.posterURL, placeholder: image)
        lbTitle.text = movie.title
    }
    
}
