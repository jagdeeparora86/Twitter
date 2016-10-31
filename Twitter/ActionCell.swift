//
//  ActionCell.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/29/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

protocol ActionCellDelegate {
    func callActionCell(actionCells : ActionCell, actionTweet : Tweet)
}

@objc protocol SwitchCellDelegate {
    @objc optional func switchCell(swtchCell: ActionCell, didChanged value : Tweet)
}

class ActionCell: UITableViewCell {
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet  var favoriteButton: UIButton!
    @IBOutlet weak var favCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    var delegate : ActionCellDelegate?
    var switcCell : SwitchCellDelegate?
    
    var actionTweet: Tweet! {
        didSet {
            
            if actionTweet.retweeted! == true {
                retweetButton.setImage(UIImage(named: "retweet_on"), for: .normal)
            }
            
            if actionTweet.favorited! == true {
                favoriteButton.setImage(UIImage(named: "favorite_on"), for: .normal)
            }
        }
    }
    
    
    @IBAction func doFavorite(_ sender: AnyObject) {
        if !actionTweet.favorited! {
            callFav()
        }
        else{
            callDestoryFav()
        }
    }
    
    @IBAction func handleRetweet(_ sender: AnyObject) {
        if !actionTweet.retweeted! {
            callRetweet()
        }
        else{
            undoRetweet()
        }
        
    }
    
    
    func callFav() {
        TwitterClient.sharedInstance?.favoriteTweet(id: actionTweet.id!, params: nil, completion: { (error: Error?) in
            if error == nil{
                self.actionTweet.favoriteCount += 1
                self.favoriteButton.setImage(UIImage(named: "favorite_on"), for: .normal)
                self.actionTweet.favorited = true
                self.callDelegate()
            }
            else
            {
                print(error?.localizedDescription)
            }
        })
    }
    
    func callDestoryFav(){
        TwitterClient.sharedInstance?.unFavoriteTweet(id: actionTweet.id!, params: nil, completion: { (error: Error?) in
            if error == nil{
                self.actionTweet.favoriteCount -= 1;
                self.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
                self.actionTweet.favorited = false
                self.callDelegate()
            }
            else
            {
                print(error?.localizedDescription)
            }
           
        })
    }
    
    func callRetweet (){
        TwitterClient.sharedInstance?.retweetTweet(id: actionTweet.id!, params: nil, completion: { (error:Error?) in
            if error == nil{
                self.actionTweet.retweetCount += 1
                self.retweetButton.setImage(UIImage(named: "retweet_on"), for: .normal)
                self.actionTweet.retweeted = true
                self.callDelegate()
                
            }
            else
            {
                print(error?.localizedDescription)
            }
        })
    }
    
    func undoRetweet(){
        TwitterClient.sharedInstance?.unRetweetTweet(id: actionTweet.id!, params: nil, completion: { (error:Error?) in
            if error == nil{
                self.actionTweet.retweetCount -= 1
                self.retweetButton.setImage(UIImage(named: "retweet"), for: .normal)
                self.actionTweet.retweeted = true
                self.callDelegate()
            }
            else
            {
                print(error?.localizedDescription)
            }
        })
    }
    
    func callDelegate(){
//        self.delegate?.callActionCell(actionCells: self, actionTweet: actionTweet);
//        switcCell?.switchCell!(switchCell: self, didChanged: actionTweet)
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
