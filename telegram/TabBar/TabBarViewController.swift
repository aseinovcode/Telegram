//
//  TabBarViewController.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let home = templateNavigationController(image: #imageLiteral(resourceName: "chat"), rootViewController: ChatController())
        let profile = templateNavigationController(image: #imageLiteral(resourceName: "profile"), rootViewController: ProfileViewController())
        
        let controller = [home, profile]
        
        viewControllers = controller
    }
    
    func templateNavigationController(image: UIImage, rootViewController: UIViewController ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        return nav
    }
    

}
