//
//  HomeViewController.swift
//  FBSearch
//
//  Created by Yang Cao on 2017/4/19.
//  Copyright © 2017年 Yang Cao. All rights reserved.
//

import UIKit
import EasyToast

class HomeViewController: UIViewController {
    
    let localstorage = UserDefaults.standard

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var Keyword: UITextField!
    
    @IBAction func clear(_ sender: Any) {
        Keyword.text = nil
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "search" {
            if (Keyword.text?.isEmpty)!{
                self.view.showToast("Enter a valid query!", position: .bottom, popTime: 3, dismissOnTap: true)
                return false
            }
            else{
                return true
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "search" {
            let barViewControllers = segue.destination as! UITabBarController
            
            let nav1 = barViewControllers.viewControllers![0] as! UINavigationController
            let destinationViewController1 = nav1.viewControllers[0] as! UserViewController
            destinationViewController1.text = Keyword.text!
            
            let nav2 = barViewControllers.viewControllers![1] as! UINavigationController
            let destinationViewController2 = nav2.viewControllers[0] as! PageViewController
            destinationViewController2.text = Keyword.text!
            
            let nav3 = barViewControllers.viewControllers![1] as! UINavigationController
            let destinationViewController3 = nav3.viewControllers[0] as! PageViewController
            destinationViewController3.text = Keyword.text!
            
            let nav4 = barViewControllers.viewControllers![3] as! UINavigationController
            let destinationViewController4 = nav4.viewControllers[0] as! GroupViewController
            destinationViewController4.text = Keyword.text!
            
            let nav5 = barViewControllers.viewControllers![4] as! UINavigationController
            let destinationViewController5 = nav5.viewControllers[0] as! EventViewController
            destinationViewController5.text = Keyword.text!
            
        }
    }
}
