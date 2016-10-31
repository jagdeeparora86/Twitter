//
//  CounterCell.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/29/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class CounterCell: UITableViewCell {
    
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    var counterTweet : Tweet!{
        didSet {
            
            retweetCountLabel.text = String("\(counterTweet.retweetCount)")
            favCountLabel.text = String("\(counterTweet.favoriteCount)")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
