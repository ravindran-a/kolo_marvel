//
//  CharactersViewController+Collection.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation
import UIKit

extension CharactersViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersVM.getCharactersCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if charactersVM.currentPage < charactersVM.totalPage && indexPath.row == charactersVM.getCharactersCount() - 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersLoadingCollectionViewCell.cellIdentifier, for: indexPath) as? CharactersLoadingCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.showLoading()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.cellIdentifier, for: indexPath) as? CharactersCollectionViewCell, charactersVM.getCharactersCount() > indexPath.row, let data = charactersVM.getCharacter(index: indexPath.row) else {
                return UICollectionViewCell()
            }
            let imageUrl = (data.thumbnail?.path ?? "") + "/standard_medium." + (data.thumbnail?.fileExtension ?? "")
            cell.setCellData(name: data.name, imageUrl: imageUrl)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if charactersVM.shouldLoadNextPage(indexPath: indexPath) {
            loadData(loadNextPage: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
}
