//
//  PlaceFavViewController.swift
//  FBSearch
//
//  Created by Yang Cao on 2017/4/27.
//  Copyright © 2017年 Yang Cao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class PlaceFavViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var placefavButton: UIBarButtonItem!
    
    
    @IBOutlet weak var tbView: UITableView!
    
    var idArray = UserDefaults.standard.array(forKey: "placeFavoriteid") as! [String]
    var nameArray = UserDefaults.standard.array(forKey: "placeFavoritename") as! [String]
    var imgURLArray = UserDefaults.standard.array(forKey: "placeFavoriteurl") as! [String]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("loading data...")
        if self.revealViewController() != nil {
            placefavButton.target = self.revealViewController()
            placefavButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.tbView.tableFooterView = UIView(frame: CGRect.zero)
        SwiftSpinner.hide()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let name = nameArray[indexPath.row] as String
        let url = imgURLArray[indexPath.row] as String
        if let nameLabel = cell.viewWithTag(3000) as? UILabel{
            nameLabel.text = name
        }
        let imgurl = NSURL(string: url)
        let imageView = cell.viewWithTag(3001) as! UIImageView
        if let data = NSData(contentsOf: (imgurl as URL?)!) {
            imageView.image = UIImage(data: data as Data)
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdetail" {
            let barViewControllers = segue.destination as! DetailTabBarController
            
            let nav1 = barViewControllers.viewControllers![0] as! UINavigationController
            nav1.title = "detail"
            let destinationViewController1 = nav1.viewControllers[0] as! DetailViewController
            
            let nav2 = barViewControllers.viewControllers![1] as! UINavigationController
            let destinationViewController2 = nav2.viewControllers[0] as! PostViewController
            
            let selectedRow = tbView.indexPathForSelectedRow!.row
            let id = idArray[selectedRow]
            let img = imgURLArray[selectedRow]
            //            print("it's here")
            //            print(id)
            
            destinationViewController1.text = id
            destinationViewController2.text = id
            destinationViewController2.img = img
            
            barViewControllers.img = img
            barViewControllers.id = id
            barViewControllers.name = nameArray[selectedRow]
            //barViewControllers.type = "user"
        }
    }


}
