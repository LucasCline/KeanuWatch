//
//  HomeScreenTableViewDelegate.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/18/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class HomeScreenTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    var dataSource: [KeanuArticle] = []
    weak var viewController: HomeScreenTableViewController?
    
    init(_ viewController: HomeScreenTableViewController) {
        super.init()
        self.viewController = viewController
        //on init of the data source, fetch the articles

        
        let networkingManager = NetworkingManager()
        networkingManager.fetchNews { (keanuResults) in
            self.dataSource = keanuResults.articles
            self.viewController?.newsTableView.reloadData()
        }
    }
    
    //this should be a separate method so we can refresh whenever we need to (e.g. when we reload the table) --maybe
    private func fetchDataSource() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Hello"
        cell.backgroundView?.backgroundColor = .black
        return cell
    }
}
