//
//  FilterCollectionViewCell.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    static let cellIdentifier: String = "FilterCollectionViewCell"
    
    @IBOutlet weak var filterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 20.0
        contentView.layer.borderWidth = 2.0
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.filterName.text = nil
    }

    func setFilterName(name: String) {
        self.filterName.text = name
    }
    
    func setSelected(selected: Bool) {
        if selected {
            contentView.layer.borderColor = UIColor.blue.cgColor
        } else {
            contentView.layer.borderColor = UIColor.black.cgColor
        }
    }
}
