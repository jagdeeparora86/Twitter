//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 11/4/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    var userScreenName : String?
    var tweets : [Tweet]?
    var userInfo: User?
    var showBack: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        print("\(userScreenName!)")
        getUserInfo()
        getUserTimeLine()
        if showBack == true {
            backButton.isHidden = false
        }
        else {
            backButton.isHidden = true
        }
    }
    
    func getUserTimeLine(){
        TwitterClient.sharedInstance?.userTimeLine(screenName: userScreenName!, success: { (tweets:[Tweet]) in
            self.tweets = tweets
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            }, faliure: { (error: Error) in
                print(error.localizedDescription)
        })
    }
    
    func getUserInfo(){
        TwitterClient.sharedInstance?.userInfo(screenName: userScreenName!, success: { (user: User) in
            self.bannerImageView.setImageWith(user.profileBackgroudImageUrl!)
            self.profileImageView.setImageWith(user.profileImageUrl!)
            self.nameLabel.text = user.name!
            self.descriptionLabel.text = user.tagLine!
            self.screenNameLabel.text = user.screenName!
            self.followingCountLabel.text = user.followingCount!
            self.followersCountLabel.text = user.followersCount!
            self.tweetsCountLabel.text = user.statusCount!
            }, faliure: { (error: Error) in
                print(error.localizedDescription)
        })
    }
    
    
    @IBAction func goBack(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
       /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension ProfileViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TweetCell
        cell.tweet = self.tweets![indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tweets != nil {
            return (self.tweets?.count)!
        }
        else {
            return 0
        }
    }
}
