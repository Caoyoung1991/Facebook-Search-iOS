//
//  postCell.swift
//  FBSearch
//
//  Created by Yang Cao on 2017/4/23.
//  Copyright © 2017年 Yang Cao. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {

    
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var postTime: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        postContent.preferredMaxLayoutWidth = 230
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
