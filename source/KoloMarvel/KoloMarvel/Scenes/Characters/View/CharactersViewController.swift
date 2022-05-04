//
//  CharactersViewController.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class CharactersViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate,
                                UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchGrid: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var historyList: UITableView!
    @IBOutlet weak var historyListHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noResultsFound: UILabel!
    
    lazy var charactersVM: CharactersViewModel = CharactersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadData()
    }
    
    func setupView() {
        spinner.stopAnimating()
        self.title = "Characters"
        searchBar.delegate = self
        setupGrid()
        setupSearchList()
        historyList.isHidden = true
        historyListHeightConstraint.constant = 0
        noResultsFound.isHidden = true
    }

    func setupGrid() {
        searchGrid.register(UINib(nibName: CharactersCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CharactersCollectionViewCell.cellIdentifier)
        searchGrid.register(UINib(nibName: CharactersLoadingCollectionViewCell.cellIdentifier, bundle: nil), forCellWithReuseIdentifier: CharactersLoadingCollectionViewCell.cellIdentifier)
        searchGrid.refreshControl = UIRefreshControl()
        searchGrid.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    func setupSearchList() {
        historyList.register(UINib(nibName: SearchTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.cellIdentifier)
    }
    
    func loadData(refreshData: Bool = false, loadNextPage: Bool = false) {
        noResultsFound.isHidden = true
        spinner.startAnimating()
        charactersVM.getCharacters(refreshData: refreshData, loadNextPage: loadNextPage) { [weak self] error in
            self?.spinner.stopAnimating()
            if error != nil {
                
            } else {
                self?.searchGrid.reloadData()
                if self?.charactersVM.getCharactersCount() == 0 {
                    self?.noResultsFound.isHidden = false
                } else {
                    self?.noResultsFound.isHidden = true
                }
            }
        }
    }
    
    @objc func pullToRefresh() {
        searchGrid.refreshControl?.endRefreshing()
        //loadData(refreshData: true)
    }
    
}
