//
//  MovieListViewController.swift
//  Movie
//
//  Created by Thành Ngô Văn on 04/12/2021.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var searchBar : SearchBarLoadable = {
        let _searchBar = SearchBarLoadable()
        _searchBar.placeholder = "Find your movie..."
        _searchBar.delegate = self
        _searchBar.barStyle = UIBarStyle.default
        _searchBar.sizeToFit()
        _searchBar.backgroundImage = UIImage()
        return _searchBar
    }()
    
    private var disposeBag = DisposeBag()
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupCollectionView()
        bindRx()
    }
    
    private func setupView() {
        title = "List Movie"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let buttonBar = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: nil, action: nil)
        buttonBar.tintColor = .white
        navigationItem.rightBarButtonItem = buttonBar
    }
    
    private func bindRx() {
        _ = searchBar.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter({ query in
                return !query.isEmpty
            })
            .subscribe { [weak self] (query) in
                self?.viewModel.searchMovie(query: query)
            }.disposed(by: disposeBag)
        
        viewModel.relayLoading.bind { [weak self] isLoading in
            self?.searchBar.isLoading = isLoading
        }.disposed(by: disposeBag)
        
        viewModel.relaySearchData.bind { [weak self] _ in
            self?.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
}

extension MovieListViewController: UISearchBarDelegate {
    
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func setupCollectionView() {
        collectionView.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCellId")
        collectionView.register(MovieItemCollectionViewCell.nib, forCellWithReuseIdentifier: MovieItemCollectionViewCell.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset.left = 16
        flowLayout.sectionInset.right = 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.relaySearchData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCellId", for: indexPath)
        header.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchBar.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchBar.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16).isActive = true
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let noOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        let height = size * 448 / 300
        return CGSize(width: size, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieItemCollectionViewCell.identifier, for: indexPath) as! MovieItemCollectionViewCell
        cell.displayData(movie: viewModel.relaySearchData.value[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard indexPath.row == viewModel.relaySearchData.value.count - 1 else {
            return
        }
        viewModel.loadMoreData()
    }
}
