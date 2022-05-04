//
//  SearchTableViewCell.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let cellIdentifier: String = "SearchTableViewCell"
    
    @IBOutlet weak var searchString: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.searchString.text = nil
    }
    
    func setData(string: String) {
        self.searchString.text = string
    }
    
}
