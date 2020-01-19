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
    lazy var delegate = HomeScreenTableViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = delegate
        newsTableView.dataSource = delegate
        
        let networkingManager = NetworkingManager()
        networkingManager.fetchNews()
    }
}
