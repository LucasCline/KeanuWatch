//
//  UIImageView+KeanuWatch.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/19/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


