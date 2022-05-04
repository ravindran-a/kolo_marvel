//
//  CharactersViewController+Search.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation
import UIKit

extension CharactersViewController {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.historyList.reloadData()
        self.historyList.isHidden = false
        self.historyListHeightConstraint.constant = 240
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        charactersVM.setSearchString(string: "")
        self.historyList.isHidden = true
        self.historyListHeightConstraint.constant = 0
        loadData(refreshData: true, loadNextPage: false)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.historyList.isHidden = true
        self.historyListHeightConstraint.constant = 0
        searchBar.resignFirstResponder()
        charactersVM.setSearchString(string: searchBar.text ?? "")
        loadData(refreshData: true, loadNextPage: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            charactersVM.setSearchString(string: "")
            self.historyList.isHidden = true
            self.historyListHeightConstraint.constant = 0
        } else {
            self.historyList.isHidden = false
            self.historyListHeightConstraint.constant = 240
        }
    }
    
}
