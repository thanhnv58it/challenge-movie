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
    
    @IBOutlet weak var backButton: UIButton!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbMovieYear: UILabel!
    @IBOutlet weak var bannerStackViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stackViewContent: UIStackView!
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
        viewModel.getMovieDetails()
    }
    
    private func setupView() {
        self.navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isHidden = true
        bannerStackViewTopConstraint.constant = 16 + getStatusBarHeight()
        backButton.layer.cornerRadius = 22
        backButton.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        backButton.setTitle(nil, for: .normal)
        backButton.setTitle(nil, for: .selected)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
    }
    
    private func displayDefaultData() {
        let movie = viewModel.movie
        lbMovieTitle.text = movie.title
        imgPoster.kf.setImage(with: movie.posterURL)
        
        let processor = BlurImageProcessor(blurRadius: 4)
        imgBackground.kf.setImage(with: movie.posterURL, options: [.processor(processor)])
    }
    
    private func displayMovieDetails(_ movie: MovieDetails?) {
        self.lbMovieYear.text = movie?.year ?? ""
        self.lbCategory.text = movie?.genre
        self.lbPlot.text = movie?.plot
        self.lbDirector.text = movie?.director
        self.lbWriter.text = movie?.writer
        self.lbActor.text = movie?.actors
        self.lbDuration.text = movie?.runtime
        self.lbRateValue.text = movie?.imdbRating
        self.lbVoteValue.text = movie?.imdbVotes
    }
    
    private func bindRxData() {
        viewModel.relayLoading.bind { [weak self] (isLoading) in
            guard let self = self else { return }
            isLoading ? self.showLoading() : self.hideLoading()
        }.disposed(by: disposeBag)
        
        viewModel.relayMovieDetails.bind { [weak self] (detail) in
            guard let self = self else { return }
            self.displayMovieDetails(detail)
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
