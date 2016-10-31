//
//  User.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/27/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenName : String?
    var profileImageUrl: URL?
    var tagLine: String?
    var dictionary : NSDictionary?
    
    init(dictionary : NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        let pimageURl = dictionary["profile_image_url_https"] as? String
        if let pimageURl = pimageURl {
            profileImageUrl = URL(string: pimageURl)
        }
        tagLine = dictionary["description"] as? String
    }
    
    static var _currentUser : User?
    class var currentUser : User? {
        
        get{
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                if let userData = userData {
                   let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            print(_currentUser?.name!)
            return _currentUser
            
        }
        set(user){
            let defaults = UserDefaults.standard
            _currentUser = user
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            }
            else{
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize()
            
        }
    }
}
