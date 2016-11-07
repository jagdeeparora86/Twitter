//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/28/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var counterLabel: UILabel!
    var tweet : Tweet?
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var tweetTextField: UITextView!
    var counter : Int?
    
    @IBOutlet weak var thumbImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextField.delegate = self
        tweetTextField.text = "Whats Happening?"
        tweetTextField.textColor = UIColor.lightGray
        thumbImageView.setImageWith((User.currentUser?.profileImageUrl!)!)
        self.automaticallyAdjustsScrollViewInsets = false
        actionView.layer.borderWidth = 0.5
        actionView.layer.borderColor = UIColor.lightGray.cgColor
        tweetTextField.becomeFirstResponder()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(
            self, selector: #selector(ComposeViewController.keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendTweet(_ sender: AnyObject) {
        TwitterClient.sharedInstance?.postTweet(status: tweetTextField.text!, completion: { (error:Error?) in
            if error == nil {
                print("Tweet Succefull")
            }
            else
            {
                print(error?.localizedDescription)
            }
        })
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }

    
    func keyBoardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.actionView.frame.origin.y = keyboardSize.height + self.actionView.frame.height
        }
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        counter =  140 - tweetTextField.text.characters.count
        counterLabel.text = "\(counter!)"
        
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
