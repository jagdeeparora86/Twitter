//
//  TweetCell.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/28/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var tweetHandlerLabel: UILabel!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!

//    var timeFormatter = DateFormatter()
//    timeFormatter.timeStyle = time
    
    var tweet: Tweet! {
        didSet {
            
            
            tweetNameLabel.text = tweet.user!.name
            thumbImageView.setImageWith(tweet.user!.profileImageUrl!)
            tweetHandlerLabel.text = tweet.user!.screenName
            tweetTimeLabel.text = tweet.getTimeInString()
            tweetContentLabel.text = tweet.text!
            retweetCountLabel.text = String(tweet.retweetCount)
            favoriteCountLabel.text = String(tweet.favoriteCount)

            if tweet.retweeted == true {
                retweetButton.setImage(UIImage(named: "retweet_on"), for: .normal)
            }
            else {
                retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
            }
            
            
            if tweet.favorited == true {
                favButton.setImage(UIImage(named: "favorite_on"), for: .normal)
            }
            else{
                favButton.setImage(UIImage(named: "favorite"), for: .normal)
            }
            
            
//            if tweet.media_included == true {
//                
//                    mediaImage.setImageWith(tweet.mediaImageUrl!)
//                
//            }
//            else{
//               mediaImage.isHidden = true
//            
//            }
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(onProfileImapTap))
            tap.delegate = self
            thumbImageView.addGestureRecognizer(tap)

            
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupProfileTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(onProfileImapTap))
        tap.delegate = self
        thumbImageView.addGestureRecognizer(tap)
    }
    
    func onProfileImapTap(){
        print("user Tapped the image")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
