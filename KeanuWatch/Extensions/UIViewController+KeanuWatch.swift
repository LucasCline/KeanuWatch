//
//  UIViewController+KeanuWatch.swift
//  KeanuWatch
//
//  Created by Amanda Bloomer  on 1/20/20.
//  Copyright © 2020 Lucas Cline. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupKeanuNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "AmericanTypewriter-CondensedBold", size: 36) ?? UIFont.systemFont(ofSize: 36),
                                                                        NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}
