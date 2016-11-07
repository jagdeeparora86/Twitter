//
//  MentionsViewController.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 11/6/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController {
    
    var tweets : [Tweet]?
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TweetCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        getMentionsTimeLine()
        setupRefreshControl()
    }
    
    
    func setupRefreshControl(){
        // refresh control
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MentionsViewController.getMentionsTimeLine), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at:0)
    }
    
    func getMentionsTimeLine(){
        TwitterClient.sharedInstance?.mentionTimeLine(success: { (tweets:[Tweet]) in
            self.tweets = tweets
            print("\(tweets)")
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }) { (error: Error) in
            print(error.localizedDescription)
            self.refreshControl.endRefreshing()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "mentionDetailSegue" {
            let cell = sender as! TweetCell
            let navigationController  = segue.destination as! UINavigationController
            let detailViewController = navigationController.topViewController as! DetailViewController
            detailViewController.tweet = cell.tweet
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MentionsViewController : UITableViewDelegate, UITableViewDataSource {
    
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
        print("This is a tweet \(cell.tweet)")
        cell.selectionStyle = .none
        return cell
    }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath)
            performSegue(withIdentifier: "mentionDetailSegue", sender: cell)
        }
    
}

