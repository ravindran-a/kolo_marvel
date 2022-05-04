//
//  ComicsViewController+Collection.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation
import UIKit

extension ComicsViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == filterGrid {
            return comicsVM.getFilterCount()
        } else {
            return comicsVM.getComicsCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == filterGrid {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.cellIdentifier, for: indexPath) as? FilterCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setFilterName(name: comicsVM.getFilterString(index: indexPath.row))
            if comicsVM.currentFilterType == comicsVM.allFilterTypes[indexPath.row] {
                cell.setSelected(selected: true)
            } else {
                cell.setSelected(selected: false)
            }
            return cell
        } else {
            if comicsVM.currentPage < comicsVM.totalPage && indexPath.row == comicsVM.getComicsCount() - 1 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsLoadingCollectionViewCell.cellIdentifier, for: indexPath) as? ComicsLoadingCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.showLoading()
                return cell
            } else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCollectionViewCell.cellIdentifier, for: indexPath) as? ComicsCollectionViewCell, comicsVM.getComicsCount() > indexPath.row, let data = comicsVM.getComic(index: indexPath.row) else {
                    return UICollectionViewCell()
                }
                let imageUrl = (data.thumbnail?.path ?? "") + "/standard_medium." + (data.thumbnail?.fileExtension ?? "")
                cell.setCellData(name: data.title, imageUrl: imageUrl)
                return cell
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == comicsGrid {
            if comicsVM.shouldLoadNextPage(indexPath: indexPath) {
                loadData(loadNextPage: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == filterGrid {
            let previousIndexPath = IndexPath(item: comicsVM.allFilterTypes.firstIndex(of: comicsVM.currentFilterType) ?? 0, section: indexPath.section)
            if let cell = collectionView.cellForItem(at: previousIndexPath) as? FilterCollectionViewCell {
                cell.setSelected(selected: false)
            }
            if let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
                cell.setSelected(selected: true)
            }
            comicsVM.setFilterType(filterType: comicsVM.allFilterTypes[indexPath.row])
            loadData(refreshData: true, loadNextPage: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == filterGrid {
            return CGSize(width: 150, height: 40)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == filterGrid {
            return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        } else {
            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
}
