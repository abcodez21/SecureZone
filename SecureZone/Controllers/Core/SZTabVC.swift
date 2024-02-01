//
//  ViewController.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 10/11/23.
//

import UIKit

final class SZTabVC: UITabBarController {
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "AppColor")
        tabBar.unselectedItemTintColor = .black
       
        setUpTabs()
    }

    private func setUpTabs(){
        
        let emailVC = SZEmailVC()
        let codeVC = SZCodeVC()
        let creditCardVC = SZCreditCardVC()
        let settingsVC = SZSettings()
        
        for vc in [emailVC,codeVC,creditCardVC,settingsVC]{
            vc.view.backgroundColor = .white
        }
    
        let nav1 = UINavigationController(rootViewController: emailVC)
        let nav2 = UINavigationController(rootViewController: codeVC)
        let nav3 = UINavigationController(rootViewController: creditCardVC)
        let nav4 = UINavigationController(rootViewController: settingsVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Emails",
                                       image: UIImage(systemName: "envelope"),
                                       tag: 1)
        
        nav2.tabBarItem = UITabBarItem(title: "Codes",
                                       image: UIImage(systemName: "barcode"),
                                       tag: 1)
        
        nav3.tabBarItem = UITabBarItem(title: "Credit Cards",
                                       image: UIImage(systemName: "creditcard"),
                                       tag: 1)
        
        nav4.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gearshape"),
                                       tag: 1)
        

        for nav in [nav1, nav2, nav3, nav4] {
            
            // setup navigation bar fill tint color
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor(named: "AppColor")
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Semibold", size: 25)!]
            nav.navigationBar.standardAppearance = appearance
            nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
            
          
        }
       
        setViewControllers(
            [nav1, nav2, nav3, nav4],
            animated: true)
        
        
    }
    
}

