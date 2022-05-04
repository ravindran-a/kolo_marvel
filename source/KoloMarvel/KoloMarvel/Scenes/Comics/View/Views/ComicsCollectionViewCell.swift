//
//  ComicsCollectionViewCell.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class ComicsCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "ComicsCollectionViewCell"

    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 6.0
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.comicName.text = nil
        self.comicImage.image = nil
    }
    
    func setCellData(name: String?, imageUrl: String?) {
        self.comicName.text = name
        self.comicImage.imageWithURL(imageUrl)
    }
}
