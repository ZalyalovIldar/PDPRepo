//
//  CatsCell.swift
//  PdpIldar
//
//  Created by Ildar Zalyalov on 09.09.16.
//  Copyright © 2016 com.flatstack. All rights reserved.
//

import UIKit

class CatsCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var catNameLabel: UILabel!
    @IBOutlet weak var catOwnerName: UILabel!
    @IBOutlet weak var graphicView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
