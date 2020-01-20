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
    var articleForSegue: KeanuArticle?
    var cachedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = delegate
        newsTableView.dataSource = delegate
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ArticleDetailViewController else {
            print("Segue failed - destination segue is not of type ArticleDetailViewController)")
            return
        }
        
        destinationVC.article = articleForSegue
        destinationVC.cachedImage = cachedImage
    }
}
