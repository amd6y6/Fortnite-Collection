//
//  CosmeticTableViewCell.swift
//  FortniteCollection
//
//  Created by Austin Dotto on 7/26/18.
//  Copyright © 2018 Austin Dotto. All rights reserved.
//

import UIKit


class CosmeticTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var obtainedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cosmeticImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
