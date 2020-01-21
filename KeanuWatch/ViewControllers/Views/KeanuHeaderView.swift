//
//  KeanuHeaderView.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/20/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class KeanuHeaderView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    var headlineArticles: [KeanuArticle] = []
    var cacheKeys: [String] = ["Article0",
                               "Article1",
                               "Article2"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("KeanuHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setupViewsWith(articles: [KeanuArticle], cache: NSCache<AnyObject,AnyObject>) {
        guard let firstArticle = articles.first else {
            print("No articles found, unable to set header view articles.")
            return
        }
        
        headlineArticles = articles
        headerLabel.text = firstArticle.title
        headerImage.image = UIImage(named: "Keanu")
        setAttributesForLabel()
        
        cacheImagesForAllHeadlineArticles(cache: cache)
    }
    
    func cacheImagesForAllHeadlineArticles(cache: NSCache<AnyObject,AnyObject>) {
        for (n, key) in cacheKeys.enumerated() {
            if let cachedImage = cache.object(forKey: key as AnyObject) as? UIImage {
                self.headerImage.image = cachedImage
            } else {
                var task: URLSessionDownloadTask?
                if let imageURLString = headlineArticles[n].urlToImage,
                    let imageURL = URL(string: imageURLString) {
                    let session = URLSession.shared
                    task = session.downloadTask(with: imageURL) { (url, response, error) in
                        if let data = try? Data(contentsOf: imageURL) {
                            DispatchQueue.main.async {
                                if let downloadedImage = UIImage(data: data) {
                                    //this if block is a debug block - just to test. needs to be removed or changed later
                                    if n == 0 {
                                        self.headerImage.image = downloadedImage
                                    }
                                    print("")
                                    cache.setObject(downloadedImage, forKey: key as AnyObject)
                                }
                            }
                        }
                    }
                }
                task?.resume()
            }
        }
    }
    
    func setAttributesForLabel() {
        let textAttributes = [
          NSAttributedString.Key.strokeColor : UIColor.black,
          NSAttributedString.Key.foregroundColor : UIColor.white,
          NSAttributedString.Key.strokeWidth : -4.0,
          NSAttributedString.Key.font : UIFont(name: "Optima-Bold", size: 22) ?? UIFont.systemFont(ofSize: 22)]
          as [NSAttributedString.Key : Any]

        headerLabel.attributedText = NSMutableAttributedString(string: headerLabel?.text ?? "Keanu", attributes: textAttributes)
    }
}
