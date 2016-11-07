//
//  DetailViewController.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/28/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetControlsCellDelegate {

    var tweet : Tweet?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.reloadData()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func profileImageTap(){
        performSegue(withIdentifier: "profileViewSegway", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 0: // handle TweetDetail
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTweetCell", for: indexPath) as! DetailTweetCell
            cell.tweet = self.tweet
            let tap = UITapGestureRecognizer(target: self, action: #selector(profileImageTap))
            tap.cancelsTouchesInView = true;
            cell.thumbImageView.addGestureRecognizer(tap)

        default:
            return cell
        }
        
        return cell
    }
    
    
    
    @IBAction func goBack(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileViewSegway" {
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.showBack = true
            profileViewController.userScreenName = (tweet?.user!.screenName)!
        }
    }
    
}
