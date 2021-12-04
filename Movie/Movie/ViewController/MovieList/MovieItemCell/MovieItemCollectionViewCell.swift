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
    
    private var gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
        setGradientBackground()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = self.wrapTitleView.bounds
    }
    
    private func setGradientBackground() {

        let colorTop =  UIColor.black.withAlphaComponent(0.01).cgColor
        let colorBottom = UIColor.black.withAlphaComponent(0.8).cgColor
                    
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.3, 1.0]
        gradientLayer.frame = self.wrapTitleView.bounds

        self.wrapTitleView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    private func setupView() {
        wrapTitleView.backgroundColor = .clear
        wrapView.layer.cornerRadius = 6;
    }

    func displayData(movie: MovieModel) {
        imgMovie.kf.setImage(with: movie.posterURL)
        lbTitle.text = movie.title
    }
    
}
