//
//  NewsArticleTableViewCell.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/19/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

class NewsArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
