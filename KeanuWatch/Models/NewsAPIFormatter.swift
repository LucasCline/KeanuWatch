//
//  NewsAPIFormatter.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/20/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation

struct NewsAPIFormatter {
    //This method will break apart the timestamp into a date which will be formatted as MM-DD-YYYY. Timestamp received from NewsAPI is typically in the format "2020-01-20T19:00:25Z".
    static func formatTimestamp(timestamp: String?) -> String? {
        //make sure timestamp exists
        guard let timestamp = timestamp else {
            print("Timestamp was nil - unable to format")
            return nil
        }
        
        // This first block breaks apart the timestamp at the "T", which separates the date from the time
        let timestampComponents = timestamp.components(separatedBy: "T")
        guard timestampComponents.count > 1 else {
            print("String - \(timestamp) improperly formatted timestamp - could not separate by character \"T\"")
            return timestamp
        }
        
        //This second block breaks apart the individual date components
        let dateComponents = timestampComponents[0].components(separatedBy: "-")
        guard dateComponents.count > 2 else {
            print("String - \(timestamp) improperly formatted timestamp - could not separate by character \"T\"")
            return timestamp
        }
        
        return "Date published: \(dateComponents[1])-\(dateComponents[2])-\(dateComponents[0])"
    }
    
    //This method simply prepends the "Author: " string to the Author's name
    static func formatAuthor(author: String?) -> String? {
        guard let author = author else {
            print("Author was nil - unable to format")
            return nil
        }
        
        return "Author: \(author)"
    }
}
