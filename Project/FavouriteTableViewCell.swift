//
//  FavouriteTableViewCell.swift
//  Project Name: UT Apartment
//  Team 8: Junyu Yao, Mingda Li, Ruiqi Liu
//  Course: CS329E
//
//  Created by Junyu Yao on 11/30/22.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favouriteLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var favouriteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
