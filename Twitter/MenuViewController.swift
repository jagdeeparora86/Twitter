//
//  MenuViewController.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 11/4/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    var tweet : Tweet?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var profileImageContainer: UIView!
    var viewControllers: [UIViewController] = []
    var tweetNavigationController : UIViewController!
    var mentionsNavigationController : UIViewController!
    var profileViewController: ProfileViewController!
    let currentUser = User.currentUser!
    var hamburgerViewController : HamburgerViewController!
    
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setUpViewControllers()
        profileImageContainer.layer.cornerRadius = 32
        profileImageView.layer.cornerRadius = 32
        profileImageView.clipsToBounds = true
        profileImageView.setImageWith(currentUser.profileImageUrl!)
        coverImageView.setImageWith(currentUser.profileBackgroudImageUrl!)
        coverImageView.clipsToBounds = true
        nameLabel.text = currentUser.name!
        screenNameLabel.text = currentUser.screenName!
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.reloadData()
    }
    
    func setUpViewControllers(){
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        profileViewController = storyBoard.instantiateViewController(withIdentifier: "profileViewController") as! ProfileViewController
        profileViewController.userScreenName = (User.currentUser?.screenName!)!
        tweetNavigationController = storyBoard.instantiateViewController(withIdentifier: "tweetsNavigationController")
        mentionsNavigationController = storyboard?.instantiateViewController(withIdentifier: "mentionsNavigationController")
        viewControllers.append(profileViewController!)
        viewControllers.append(tweetNavigationController!)
        viewControllers.append(mentionsNavigationController!)
        
        hamburgerViewController.contentViewController = tweetNavigationController!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

}

extension MenuViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        let title = ["Profile", "Home TimeLine", "Mentions"]
        cell.menuLabel.text = title[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        hamburgerViewController.contentViewController =  viewControllers[indexPath.row]
    
    
    }

}
