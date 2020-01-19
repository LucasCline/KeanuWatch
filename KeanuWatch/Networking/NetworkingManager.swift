//
//  NetworkingManager.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/18/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import Foundation
import Alamofire
import Keys

class NetworkingManager {
    private let apiKey = KeanuWatchKeys().newsAPIKey
    func fetchNews(topic: String? = nil, completionHandler: @escaping (KeanuResults) -> ())  {
        let newsTopic: String = topic ?? "Keanu%20Reeves"

        Alamofire.request("https://newsapi.org/v2/everything?q=\(newsTopic)",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["x-api-key": apiKey]).responseJSON { (response) in
                            guard response.result.isSuccess else {
                                print("error during request")
                                return
                            }

                            guard let responseData = response.data else {
                                print("no data found in response")
                                return
                            }
                            
                            do {
                                let articleData: KeanuResults = try JSONDecoder().decode(KeanuResults.self, from: responseData)
                                //print(articleData)
                                completionHandler(articleData)
                                //save data somewhere
                            } catch {
                                print(error.localizedDescription)
                            }
                            
        }
    }
}
