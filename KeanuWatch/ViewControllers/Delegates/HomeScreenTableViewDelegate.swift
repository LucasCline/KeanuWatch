//
//  HomeScreenTableViewDelegate.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/18/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class HomeScreenTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    var dataSource: [KeanuArticle] = [] //this contains ALL of the news sources
    var tableViewNewsSource: [KeanuArticle] = [] //this contains the news sources to be displayed as rows in the table
    var headlineNewsSource: [KeanuArticle] = [] //this contains the news sources to be displayed in the header view
    var cache: NSCache<AnyObject,AnyObject> = NSCache()
    weak var viewController: HomeScreenTableViewController?
    
    init(_ viewController: HomeScreenTableViewController) {
        super.init()
        self.viewController = viewController
        fetchDataSource()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewNewsSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIDevice.current.orientation.isLandscape ? 0 : 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsArticleCell", for: indexPath) as? NewsArticleTableViewCell else {
            print("Unable to cast the table view cell to a NewsArticleTableViewCell -- returning a blank UITableViewCell")
            return UITableViewCell()
        }
        
        let article = tableViewNewsSource[indexPath.row]

        cell.title.text = article.title
        cell.title.font = UIFont(name: "Optima-BoldItalic", size: 18)
        cell.title.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.articleImage.image = UIImage(named: "Keanu")
        
        //if a cached version of the image exists, set the cell's image to that, if not, download and cache the image, finally setting it upon completion
        if let cachedImage = cache.object(forKey: indexPath.row as AnyObject) as? UIImage {
            cell.articleImage.image = cachedImage
        } else {
            var task: URLSessionDownloadTask?
            if let imageURLString = article.urlToImage,
                let imageURL = URL(string: imageURLString) {
                let session = URLSession.shared
                task = session.downloadTask(with: imageURL) { (url, response, error) in
                    if let data = try? Data(contentsOf: imageURL) {
                        DispatchQueue.main.async {
                            if let cellToUpdate = tableView.cellForRow(at: indexPath) as? NewsArticleTableViewCell,
                                let downloadedImage = UIImage(data: data) {
                                cellToUpdate.articleImage.image = downloadedImage
                                self.cache.setObject(downloadedImage, forKey: indexPath.row as AnyObject)
                            }
                        }
                    }
                }
            }
            task?.resume()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController?.articleForSegue = tableViewNewsSource[indexPath.row]
        viewController?.cachedImage = cache.object(forKey: indexPath.row as AnyObject) as? UIImage
        viewController?.performSegue(withIdentifier: "articleDetail", sender: viewController)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func fetchDataSource() {
        let networkingManager = NetworkingManager()
        networkingManager.fetchNews { (keanuResults) in
            self.dataSource = keanuResults.articles
            
            let allArticles = self.splitArticles(articles: self.dataSource)

            //if there is more than one article, then this will produce two arrays and we can have different articles in the header and table view
            //if there is NOT more than one article, we will duplicate the articles in the table view and header view
            if allArticles.count == 2 {
                self.headlineNewsSource = allArticles.first ?? []
                self.tableViewNewsSource = allArticles.last ?? []
            } else {
                self.headlineNewsSource = self.dataSource
                self.tableViewNewsSource = self.dataSource
            }
            
            self.viewController?.newsTableView.reloadData()
            self.viewController?.headerView.setupViewsWith(articles: self.headlineNewsSource, cache: self.cache)
            self.viewController?.hideMaskingView()
        }
    }
    
    
    private func splitArticles(articles: [KeanuArticle]) -> [[KeanuArticle]] {
        var headlineArticles: [KeanuArticle] = []
        var tableViewArticles: [KeanuArticle] = []
        for (n, article) in articles.enumerated() {
            if n < 1 {
                headlineArticles.append(article)
            } else {
                tableViewArticles.append(article)
            }
        }
        
        return [headlineArticles, tableViewArticles]
    }
}
