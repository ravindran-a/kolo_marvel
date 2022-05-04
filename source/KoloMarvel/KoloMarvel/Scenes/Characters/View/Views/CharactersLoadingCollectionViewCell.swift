//
//  CharactersLoadingCollectionViewCell.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class CharactersLoadingCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "CharactersLoadingCollectionViewCell"
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        spinner.stopAnimating()
    }
    
    func showLoading() {
        spinner.startAnimating()
    }

}
