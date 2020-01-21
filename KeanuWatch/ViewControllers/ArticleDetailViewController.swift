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
    
    @IBOutlet weak var matrixLettersView: JSMatrixCodeRainView!
    @IBOutlet weak var landscapeImageView: UIImageView!
    var article: KeanuArticle?
    var cachedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewsFromArticleData()
        setupGestures()
        setupKeanuNavigationBar()
        setupFonts()
        matrixLettersView.isHidden = true
        view.backgroundColor = UIColor(red: 0, green: 0.0745, blue: 0.1569, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewDidLayoutSubviews() {
        if UIDevice.current.orientation.isLandscape {
            landscapeImageView.isHidden = false
        } else {
            landscapeImageView.isHidden = true
        }
    }
    
    private func setViewsFromArticleData() {
        articleTitle.text = article?.title
        articleAuthor.text = NewsAPIFormatter().formatAuthor(author: article?.author)
        timePublished.text = NewsAPIFormatter().formatTimestamp(timestamp: article?.publishedAt)
        articleText.text = article?.content
        
        if articleText.text.contains("Matrix") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.matrixLettersView.isHidden = false
            }
        }
        
        //if there is no cached image, the image doesn't exist, so collapse that view to prevent an awkward space
        guard let cachedImage = self.cachedImage else {
            collapseImageView()
            return
        }
        
        articleImage.image = cachedImage
        landscapeImageView.image = cachedImage
    }
    
    private func collapseImageView() {
        articleImage.image = nil
        landscapeImageView.image = nil
        imageHeight.constant = 0
    }
    
    private func setupGestures() {
        setupLinkTappedGesture()
    }
    
    private func setupLinkTappedGesture() {
        let linkTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.linkTapped(_:)))
        articleLink.addGestureRecognizer(linkTapGesture)
    }
    
    private func setupFonts() {
        articleTitle.font = UIFont(name: "Optima-Bold", size: 24) ?? UIFont.systemFont(ofSize: 24)
        timePublished.font = UIFont(name: "Optima-Italic", size: 17) ?? UIFont.systemFont(ofSize: 17)
        articleAuthor.font = UIFont(name: "Optima-Italic", size: 17) ?? UIFont.systemFont(ofSize: 17)
        articleText.font = UIFont(name: "Optima-Regular", size: 15) ?? UIFont.systemFont(ofSize: 16)
    }
    
    @objc private func linkTapped(_ sender: UITapGestureRecognizer) {
        guard let urlString = article?.url,
            let url = URL(string: urlString) else {
            print("No url found for link - cannot open link to article")
            return
        }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
