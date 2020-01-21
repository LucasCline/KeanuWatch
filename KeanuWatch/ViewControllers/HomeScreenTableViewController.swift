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
    @IBOutlet weak var headerView: KeanuHeaderView!
    @IBOutlet weak var maskingView: UIImageView!
    
    lazy var delegate = HomeScreenTableViewDelegate(self)
    var articleForSegue: KeanuArticle?
    var cachedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeanuNavigationBar()
        setupGestures()
        newsTableView.delegate = delegate
        newsTableView.dataSource = delegate
        newsTableView.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = UIColor.black
        view.backgroundColor = UIColor(red: 0, green: 0.0745, blue: 0.1569, alpha: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        headerView.isHidden = UIDevice.current.orientation.isLandscape ? true : false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ArticleDetailViewController else {
            print("Segue failed - destination segue is not of type ArticleDetailViewController)")
            return
        }
        
        destinationVC.article = articleForSegue
        destinationVC.cachedImage = cachedImage
    }
    
    func hideMaskingView() {
        UIView.animate(withDuration: 3.0) {
            self.maskingView.alpha = 0.0
        }
    }
    
    private func setupGestures() {
        setupHeadlineArticleTappedGesture()
    }
    
    private func setupHeadlineArticleTappedGesture() {
        let headlineArticleTapped = UITapGestureRecognizer(target: self, action: #selector(self.headlineArticleTapped(_:)))
        headerView.addGestureRecognizer(headlineArticleTapped)
    }
    
    @objc private func headlineArticleTapped(_ sender: UITapGestureRecognizer) {
        guard delegate.headlineNewsSource.count > 0 else {
            print("No headline article found - will not transition to details screen")
            return
        }
        
        articleForSegue = delegate.headlineNewsSource[0]
        performSegue(withIdentifier: "articleDetail", sender: self)
    }
}
