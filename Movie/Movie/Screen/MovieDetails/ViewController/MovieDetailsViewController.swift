//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by Thành Ngô Văn on 05/12/2021.
//

import UIKit
import Kingfisher
import RxSwift

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var stackViewContent: UIStackView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbMovieYear: UILabel!
    @IBOutlet weak var bannerStackViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbPlot: UILabel!
    @IBOutlet weak var lbDirector: UILabel!
    @IBOutlet weak var lbWriter: UILabel!
    @IBOutlet weak var lbActor: UILabel!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbRateValue: UILabel!
    @IBOutlet weak var lbVoteValue: UILabel!
    
    var viewModel: MovieDetailsViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        displayDefaultData()
        bindRxData()
    }
    
    private func setupView() {
        navigationController?.navigationBar.isHidden = true
        bannerStackViewTopConstraint.constant = 16 + getStatusBarHeight()
        backButton.layer.cornerRadius = 22
        backButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        backButton.setTitle(nil, for: .normal)
        backButton.setTitle(nil, for: .selected)
        
    }
    
    private func displayDefaultData() {
        let movie = viewModel.movie
        lbMovieTitle.text = movie.title
        lbMovieYear.text = ""
        imgPoster.kf.setImage(with: movie.posterURL)
        
        let processor = BlurImageProcessor(blurRadius: 4)
        imgBackground.kf.setImage(with: movie.posterURL, options: [.processor(processor)])
    }
    
    private func bindRxData() {
        viewModel.relayLoading.bind { [weak self] (isLoading) in
            guard let self = self else { return }
            isLoading ? self.showLoading() : self.hideLoading()
        }.disposed(by: disposeBag)
        
        viewModel.relayMovieDetails.bind { [weak self] (detail) in
            guard let self = self else { return }
            self.lbMovieYear.text = detail?.year
            self.lbCategory.text = detail?.genre
            self.lbPlot.text = detail?.plot
            self.lbDirector.text = detail?.director
            self.lbWriter.text = detail?.writer
            self.lbActor.text = detail?.actors
            self.lbDuration.text = detail?.runtime
            self.lbRateValue.text = detail?.imdbRating
            self.lbVoteValue.text = detail?.imdbVotes
        }.disposed(by: disposeBag)
        
        viewModel.relayError.bind { [weak self] (message) in
            guard let message = message, !message.isEmpty else {
                return
            }
            self?.showErrorAlert(message: message)
        }.disposed(by: disposeBag)
        
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print(self.classForCoder, "Deinit")
    }
    
}

extension MovieDetailsViewController {
    func showLoading() {
        stackViewContent.isHidden = true
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        stackViewContent.isHidden = false
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }
}
