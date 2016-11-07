//
//  DetailTweetCell.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/28/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class DetailTweetCell: UITableViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    
    @IBOutlet weak var tweetTimeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetHandleLabel: UILabel!
    @IBOutlet weak var tweetNameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet  var favoriteButton: UIButton!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    var tweet : Tweet! {
        didSet {
            tweetNameLabel.text = tweet.user!.name
            thumbImageView.setImageWith(tweet.user!.profileImageUrl!)
            tweetHandleLabel.text = tweet.user!.screenName
            tweetTextLabel.text = tweet.text!
            tweetTimeLabel.text = tweet.getTimeInString()
            if tweet.retweeted! == true {
                retweetButton.setImage(UIImage(named: "retweet_on"), for: .normal)
            }
            
            if tweet.favorited! == true {
                favoriteButton.setImage(UIImage(named: "favorite_on"), for: .normal)
            }
            
            favCountLabel.text = "\(tweet.favoriteCount)"
            retweetCountLabel.text = "\(tweet.retweetCount)"
            
        }
    }
    
    func imageTapped(img: AnyObject)
    {
        // Your action
        print("made it inside the tap bro")
    }
    @IBAction func doFavorite(_ sender: AnyObject) {
        if !tweet.favorited! {
            callFav()
        }
        else{
            callDestoryFav()
        }
    }
    
    @IBAction func handleRetweet(_ sender: AnyObject) {
        if !tweet.retweeted! {
            callRetweet()
        }
        else{
            undoRetweet()
        }
        
    }
    
    func callFav() {
        TwitterClient.sharedInstance?.favoriteTweet(id: tweet.id!, params: nil, completion: { (error: Error?) in
            if error == nil{
                self.tweet.favoriteCount += 1
                self.favoriteButton.setImage(UIImage(named: "favorite_on"), for: .normal)
                self.tweet.favorited = true
                self.callDelegate()
                self.favCountLabel.text = String(self.tweet.favoriteCount)
            }
            else
            {
                print(error?.localizedDescription)
            }
        })
    }
    
    func callDestoryFav(){
        TwitterClient.sharedInstance?.unFavoriteTweet(id: tweet.id!, params: nil, completion: { (error: Error?) in
            if error == nil{
                self.tweet.favoriteCount -= 1;
                self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
                self.tweet.favorited = false
                self.callDelegate()
                self.favCountLabel.text = String(self.tweet.favoriteCount)
                
            }
            else
            {
                print(error?.localizedDescription)
            }
            
        })
    }
    
    func callRetweet (){
        TwitterClient.sharedInstance?.retweetTweet(id: tweet.id!, params: nil, completion: { (error:Error?) in
            if error == nil{
                self.tweet.retweetCount += 1
                self.retweetButton.setImage(UIImage(named: "retweet_on"), for: .normal)
                self.tweet.retweeted = true
                self.callDelegate()
                self.retweetCountLabel.text = String(self.tweet.retweetCount)
                
            }
            else
            {
                print(error?.localizedDescription)
            }
        })
    }
    
    func undoRetweet(){
        TwitterClient.sharedInstance?.unRetweetTweet(id: tweet.id!, params: nil, completion: { (error:Error?) in
            if error == nil{
                self.tweet.retweetCount -= 1
                self.retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
                self.tweet.retweeted = true
                self.callDelegate()
                self.retweetCountLabel.text = String(self.tweet.retweetCount)
            }
            else
            {
                print(error?.localizedDescription)
            }
        })
    }
    
    func callDelegate(){
        //        self.delegate?.callActionCell(actionCells: self, tweet: tweet);
        //        switcCell?.switchCell!(switchCell: self, didChanged: tweet)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("awaken")
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.test))
//        tap.delegate = self
//        thumbImageView.addGestureRecognizer(tap)
    }
    
    func test(){
        print("test")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
