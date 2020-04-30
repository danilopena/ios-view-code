//
//  CustomTabBarController.swift
//  ios-view-code
//
//  Created by Danilo Pena on 28/04/20.
//  Copyright © 2020 Danilo Pena. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let characterVc = CharacterController()
        characterVc.view.backgroundColor = .white
        characterVc.navigationItem.title = "Characters"
        characterVc.navigationController?.navigationBar.prefersLargeTitles = true
        
        let navCharacter = UINavigationController(rootViewController: characterVc)
        navCharacter.tabBarItem.title = "Character"
        navCharacter.tabBarItem.image = #imageLiteral(resourceName: "ic-tab-chars")
        
        let location = UIViewController()
        location.tabBarItem.title = "Location"
        location.tabBarItem.image = #imageLiteral(resourceName: "ic-tab-location")
        location.view.backgroundColor = .white

        let episode = UIViewController()
        episode.tabBarItem.title = "Episode"
        episode.tabBarItem.image = #imageLiteral(resourceName: "ic-tab-episode")
        episode.view.backgroundColor = .white

        viewControllers = [navCharacter, location, episode]
    }
    
    func makeStyle() {
        tabBar.isTranslucent = false
        tabBar.unselectedItemTintColor = Colors.graybase_Gray1
        tabBar.tintColor = Colors.indigo
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
