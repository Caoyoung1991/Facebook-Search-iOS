//
//  customCell.swift
//  FBSearch
//
//  Created by Yang Cao on 2017/4/23.
//  Copyright © 2017年 Yang Cao. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var firstLabelView: UILabel!
    @IBOutlet weak var secondView: UIView!
    
    
    @IBOutlet weak var pictureView1: UIImageView!
    @IBOutlet weak var pictureView2: UIImageView!
    
    @IBOutlet weak var secondHeightConstrain: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var showsDetails = false {
        didSet {
            secondHeightConstrain.priority = showsDetails ? 250 : 999
        }
    }

}
