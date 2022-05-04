//
//  ComicsLoadingCollectionViewCell.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class ComicsLoadingCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "ComicsLoadingCollectionViewCell"
    
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
