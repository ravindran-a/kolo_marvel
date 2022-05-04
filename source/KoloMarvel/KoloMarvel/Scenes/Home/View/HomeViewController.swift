//
//  HomeViewController.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabViews()
    }
    
    func setupTabViews() {
        
        // Create Tab one
        guard let tabOneController = getCharactersViewController() else {
            return
        }
        let tabBarOneItem = UITabBarItem(title: "Characters", image: nil, selectedImage: nil)
        let navigationOne = UINavigationController(rootViewController: tabOneController)
        navigationOne.tabBarItem = tabBarOneItem
        
        // Create Tab two
        guard let tabTwoController = getComicsViewController() else {
            return
        }
        let tabBarTwoItem = UITabBarItem(title: "Comics", image: nil, selectedImage: nil)
        let navigationTwo = UINavigationController(rootViewController: tabTwoController)
        navigationTwo.tabBarItem = tabBarTwoItem
        
        self.viewControllers = [navigationOne, navigationTwo]
        
    }
    
    func getCharactersViewController() -> UIViewController? {
        return UIStoryboard(name: "Characters", bundle: nil).instantiateViewController(withIdentifier: "CharactersViewController") as? CharactersViewController
    }
    
    func getComicsViewController() -> UIViewController? {
        return UIStoryboard(name: "Comics", bundle: nil).instantiateViewController(withIdentifier: "ComicsViewController") as? ComicsViewController
    }
    
}
