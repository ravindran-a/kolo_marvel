//
//  ComicsViewController.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class ComicsViewController: UIViewController, UICollectionViewDelegate,
                            UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var comicsGrid: UICollectionView!
    @IBOutlet weak var filterGrid: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    lazy var comicsVM: ComicsViewModel = ComicsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    func setupView() {
        spinner.stopAnimating()
        self.title = "Comics"
        setupGrids()
    }

    func setupGrids() {
        filterGrid.register(UINib(nibName: FilterCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: FilterCollectionViewCell.cellIdentifier)
        comicsGrid.register(UINib(nibName: ComicsCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: ComicsCollectionViewCell.cellIdentifier)
        comicsGrid.register(UINib(nibName: ComicsLoadingCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: ComicsLoadingCollectionViewCell.cellIdentifier)
        comicsGrid.refreshControl = UIRefreshControl()
        comicsGrid.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    func loadData(refreshData: Bool = false, loadNextPage: Bool = false) {
        spinner.startAnimating()
        comicsVM.getComics(refreshData: refreshData, loadNextPage: loadNextPage) { [weak self] error in
            self?.spinner.stopAnimating()
            if error != nil {
                
            } else {
                self?.comicsGrid.reloadData()
            }
        }
    }
    
    @objc func pullToRefresh() {
        comicsGrid.refreshControl?.endRefreshing()
        //loadData(refreshData: true)
    }
    
}
