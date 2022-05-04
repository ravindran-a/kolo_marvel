//
//  CharactersCollectionViewCell.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "CharactersCollectionViewCell"

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 6.0
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.characterName.text = nil
        self.characterImage.image = nil
    }
    
    func setCellData(name: String?, imageUrl: String?) {
        self.characterName.text = name
        self.characterImage.imageWithURL(imageUrl)
    }

}
