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
    var cache: NSCache<AnyObject,AnyObject> = NSCache()
    weak var viewController: HomeScreenTableViewController?
    
    init(_ viewController: HomeScreenTableViewController) {
        super.init()
        self.viewController = viewController
        fetchDataSource()
    }
    
    private func fetchDataSource() {
        let networkingManager = NetworkingManager()
        networkingManager.fetchNews { (keanuResults) in
            self.dataSource = keanuResults.articles
            self.viewController?.newsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsArticleCell", for: indexPath) as? NewsArticleTableViewCell else {
            print("Unable to cast the table view cell to a NewsArticleTableViewCell -- returning a blank UITableViewCell")
            return UITableViewCell()
        }
        
        let article = dataSource[indexPath.row]

        cell.title.text = article.title
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
        viewController?.articleForSegue = dataSource[indexPath.row]
        viewController?.cachedImage = cache.object(forKey: indexPath.row as AnyObject) as? UIImage
        viewController?.performSegue(withIdentifier: "articleDetail", sender: viewController)
    }
}
