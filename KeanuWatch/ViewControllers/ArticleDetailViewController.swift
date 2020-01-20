//
//  ArticleDetailViewController.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/20/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var timePublished: UILabel!
    @IBOutlet weak var articleText: UITextView!
    @IBOutlet weak var articleLink: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    var article: KeanuArticle?
    var cachedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsFromArticleData()
    }
    
    func setViewsFromArticleData() {
        articleTitle.text = article?.title
        articleAuthor.text = article?.author
        timePublished.text = article?.publishedAt
        articleText.text = article?.content
        articleLink.text = article?.url
        guard let cachedImage = self.cachedImage else {
            articleImage.image = nil
            imageHeight.constant = 0
            return
        }
        
        articleImage.image = cachedImage
    }
}
