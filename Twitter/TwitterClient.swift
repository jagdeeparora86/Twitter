//
//  TwitterClient.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/27/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com/")!, consumerKey: "jCvhX2NsPoyXneaexYszhJu1C", consumerSecret: "HzgFTuAZMRnYY1hvHMu3zhGO7YebhiEIBF5y4ARdjBAEGckOay")
    
    var successLogin: (() -> ())?
    var faliureLogin: ((Error) -> ())?
    
    func doLogin(success : @escaping () -> (), faliure: @escaping (Error)->()){
        successLogin = success
        faliureLogin = faliure
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "myTwitter://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?) in
            let authorizeUrl = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            UIApplication.shared.open(authorizeUrl!, options: [:], completionHandler: nil)
            }, failure: { (error: Error?) in
                self.faliureLogin?(error!)
        })
    }
    
    func handleOpenUrl(url : URL){
        
        let requestToken = BDBOAuth1Credential(queryString: url.query!)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.requestSerializer.saveAccessToken(accessToken!)
            print("\(self.requestSerializer.accessToken!)")
            TwitterClient.sharedInstance?.userAccount(success: { (user: User) in
                User.currentUser = user
                print(user)
                }, faliure: { (error:Error) in
            })
            
            self.successLogin?()
            
        }) { (error: Error?) in
            self.faliureLogin?(error!)
        }
    }
    
    
    
    func logOut(){
        User.currentUser = nil
        deauthorize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userDidLogOut"), object: nil)
    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), faliure: @escaping (Error) ->()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task:URLSessionDataTask, respone:Any?) in
            let dictionaries = respone as! [NSDictionary];
            print("\(respone)")
            let tweets = Tweet.tweetsWithArray(dictionaries:  dictionaries)
            success(tweets)
        }) { (task:URLSessionDataTask?, error:Error) in
            faliure(error)
        }
    }
    
    func userAccount(success : @escaping (User) -> (), faliure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters:  nil, progress: nil, success: { (task : URLSessionDataTask, response: Any?) in
            let userDictonary = response as! NSDictionary
            let user = User(dictionary: userDictonary)
            success(user)
            }, failure: { (task: URLSessionDataTask?, error: Error) in
                faliure(error)
        })
        
    }
    
    func postTweet(status : String, completion : @escaping (Error?) -> ()){
        post("1.1/statuses/update.json", parameters: ["status" : status], progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            print("tweet was successfull")
            completion(nil)
        }) { (task: URLSessionDataTask?, error: Error) in
            completion(error)
        }
    }
    
    func favoriteTweet(id: Int, params: NSDictionary?, completion: @escaping (Error?) -> ()) {
        post("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, respone: Any?) in
            print("favorite is done")
            completion(nil)
        }) { (task:URLSessionDataTask?, error:Error) in
            completion(error)
        }
        
    }
    
    func unFavoriteTweet(id: Int, params: NSDictionary?, completion: @escaping (Error?) -> ()) {
        post("1.1/favorites/destroy.json?id=\(id)", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, respone: Any?) in
            print("favorite is done")
            completion(nil)
        }) { (task:URLSessionDataTask?, error:Error) in
            completion(error)
        }
        
    }
    
    func retweetTweet(id: Int, params: NSDictionary?, completion: @escaping (Error?) -> ()){
        post("1.1/statuses/retweet/\(id).json", parameters: params, progress: nil, success: { (task:URLSessionDataTask, response:Any?) in
            completion(nil)
        }) { (task: URLSessionDataTask?, error:Error) in
                completion(error)
        }
    
    }
    
    func unRetweetTweet(id: Int, params: NSDictionary?, completion: @escaping (Error?) -> ()){
        post("1.1/statuses/unretweet/\(id).json", parameters: params, progress: nil, success: { (task:URLSessionDataTask, response:Any?) in
            completion(nil)
        }) { (task: URLSessionDataTask?, error:Error) in
            completion(error)
        }
        
    }

    
}


