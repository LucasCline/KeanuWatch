//
//  HomeScreenTableViewController.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/18/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class HomeScreenTableViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    lazy var delegate = HomeScreenTableViewDelegate(self)
    var keanuResults2: KeanuResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = delegate
        newsTableView.dataSource = delegate
    }
}

//We are fetching KeanuResults and getting them here. We need to get just the articles to pass to the delegate.
//I think I'd like to have the data source fetch the news when it is instantiated. That way, the VC knows nothing of it.
//
