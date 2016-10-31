//
//  Tweet.swift
//  Twitter
//
//  Created by Singh, Jagdeep on 10/27/16.
//  Copyright © 2016 Singh, Jagdeep. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var id: Int?
    var text: String?
    var timeStamp : Date?
    var retweetCount = 0
    var favoriteCount = 0
    var name : String?
    var user : User?
    var retweeted : Bool?
    var favorited : Bool?
    var media_included = Bool()
    var mediaImageUrl: URL!

    
    
    init(dictonary : NSDictionary) {
        var mediasDict : NSDictionary?
        id = dictonary["id"] as? Int
        user = User(dictionary : (dictonary["user"] as? NSDictionary)!)
        text = dictonary["text"] as? String
        retweetCount = (dictonary["retweet_count"] as? Int) ?? 0
        favoriteCount =  (dictonary["favorite_count"] as? Int) ?? 0
        let timeStampString = dictonary["created_at"] as? String
        let formatter = DateFormatter()
        retweeted = dictonary["retweeted"] as? Bool
        favorited = dictonary["favorited"] as? Bool
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timeStamp = formatter.date(from: timeStampString!)
        mediasDict = dictonary["entities"] as? NSDictionary
        if let media = mediasDict?.value(forKey: "media") as? [NSDictionary?]{
            let media_url = media[0]!.value(forKey: "media_url_https") as! String
            self.mediaImageUrl = URL(string: media_url)
            media_included = true
            
        }
        else{
            media_included = false
        }
        
    }
    
    class func tweetsWithArray(dictionaries : [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictonary in dictionaries {
            let tweet = Tweet(dictonary: dictonary)
            tweets.append(tweet)
        }
        return tweets
    }
    
    func getTimeInString() -> String? {
        let calender = Calendar.current
        let unitFlags = Set([Calendar.Component.year, Calendar.Component.weekOfYear, Calendar.Component.month, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second]) as Set<Calendar.Component>
        let components:DateComponents = calender.dateComponents(unitFlags, from: timeStamp!, to: Date())
        
        if (components.year! >= 1) {
            return "\(components.year!)y"
        } else if (components.month! >= 2) {
            return "\(components.month!)m"
        } else if (components.weekOfYear! >= 1) {
            return "\(components.weekOfYear!)w"
        } else if (components.day! >= 1) {
            return "\(components.day!)d"
        } else if (components.hour! >= 1) {
            return "\(components.hour!)h"
        } else if (components.minute! >= 1) {
            return "\(components.minute!)m"
        } else if (components.second! >= 1) {
            return "\(components.second!)s"
        }
        
        return "0s"
    }

}
