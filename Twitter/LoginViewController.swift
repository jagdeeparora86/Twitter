//
//  LoginViewController.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/25/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginTwitter(_ sender: AnyObject) {
        let twitterClient = TwitterClient.sharedInstance!
        twitterClient.deauthorize()
        twitterClient.doLogin(success: { 
            print("login Successfull")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let hamburgerVewController = storyBoard.instantiateViewController(withIdentifier: "hamburgerViewController") as! HamburgerViewController
            let menuViewController = storyBoard.instantiateViewController(withIdentifier: "menuViewController")
            hamburgerVewController.menuViewController = menuViewController
            self.performSegue(withIdentifier: "hamburgerSegue", sender: nil)
        }) { (error:Error) in
                print(error.localizedDescription)
        }
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
