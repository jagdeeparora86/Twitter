//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/27/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var refreshControl: UIRefreshControl!
    
    let twitterClient = TwitterClient.sharedInstance!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        getHomeTimeLine()
        setupRefreshControl()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: AnyObject) {
        twitterClient.logOut()
    }
    
    
    func setupRefreshControl(){
        // refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TweetsViewController.getHomeTimeLine), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at:0)
    }
    
    func getHomeTimeLine(){
        twitterClient.homeTimeLine(success: { (tweets:[Tweet]) in
            self.tweets = tweets
            print("\(tweets)")
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }) { (error: Error) in
            print(error.localizedDescription)
            self.refreshControl.endRefreshing()
        }
        
    }
    
    
    @IBAction func handleCompose(_ sender: AnyObject) {
        
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            let cell = sender as! TweetCell
            let navigationController  = segue.destination as! UINavigationController
            let detailViewController = navigationController.topViewController as! DetailViewController
            
//            let indexpath = tableView.indexPath(for: cell)
            detailViewController.tweet = cell.tweet
            
        }
        else
            if segue.identifier == "composeSegue" {
                let navigationController  = segue.destination as! UINavigationController
                let composeViewController = navigationController.topViewController as! ComposeViewController
               // composeViewController.tweet = cell.tweet
                
        }
    
     }
    
    
}

// handle the tableView and cells.
extension TweetsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
}
