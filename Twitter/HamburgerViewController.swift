//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 11/4/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    @IBOutlet weak var contentViewLeftMarginConstrain: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    var originalLeftMargin : CGFloat!
    
    var contentViewController: UIViewController!{
        didSet (oldViewController) {
            view.layoutIfNeeded()
            if oldViewController != nil {
                oldViewController.willMove(toParentViewController: nil)
                oldViewController.view.removeFromSuperview()
            }
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.view.layoutIfNeeded()
                self.contentViewLeftMarginConstrain.constant = 0;
            })
        }
    }
    
    var menuViewController : UIViewController! {
        didSet (oldViewController) {
            view.layoutIfNeeded()
            if oldViewController != nil {
                oldViewController.willMove(toParentViewController: nil)
                oldViewController.view.removeFromSuperview()
            }
            menuViewController.willMove(toParentViewController: self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMove(toParentViewController: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        if sender.state == .began {
            originalLeftMargin = contentViewLeftMarginConstrain.constant
            
        } else if sender.state == .changed {
            contentViewLeftMarginConstrain.constant = originalLeftMargin + translation.x
            
        } else if sender.state == .ended{
            UIView.animate(withDuration: 0.5, animations: {
                if velocity.x > 0 {
                    self.contentViewLeftMarginConstrain.constant = self.view.frame.size.width - 50
                    self.contentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
                } else {
                    self.contentViewLeftMarginConstrain.constant = 0;
                    self.view.layoutIfNeeded()
                }
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
