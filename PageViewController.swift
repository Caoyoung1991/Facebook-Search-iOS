//
//  PageViewController.swift
//  FBSearch
//
//  Created by Yang Cao on 2017/4/26.
//  Copyright © 2017年 Yang Cao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class PageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tmpfavoriteID = UserDefaults.standard.array(forKey: "pageFavoriteid") as! [String]
    
    @IBOutlet weak var tbView: UITableView!
    var text:String = ""
    var nameArray = [String]()
    var imgURLArray = [String]()
    var idArray = [String]()
    var nextPage:String = ""
    var prePage:String = ""
    
    @IBOutlet weak var preButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("loading data...")
        if self.revealViewController() != nil {
            pageButton.target = self.revealViewController()
            pageButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        self.tbView.tableFooterView = UIView(frame: CGRect.zero)
        print(text)
        self.preButton.isEnabled = false
        Alamofire.request("http://sample-env.xyhsmeh2ph.us-west-2.elasticbeanstalk.com/", parameters: ["search": text, "type": "page"]).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                print("Page Validation Successful")
                let JSON = response.result.value
                print((JSON! as AnyObject).value(forKey:"data") as Any)
                print("second time")
                if let userArray = (JSON! as AnyObject).value(forKey:"data") as? NSArray {
                    for user in userArray{
                        if let userDict = user as? NSDictionary {
                            if let name = userDict.value(forKey: "name") {
                                self.nameArray.append(name as! String)
                                print(name)
                            }
                            if let id = userDict.value(forKey: "id") {
                                self.idArray.append(id as! String)
                                print(id)
                            }
                            if let picArray = userDict.value(forKey: "picture"){
                                print("debug1")
                                if let picData = (picArray as AnyObject).value(forKey: "data"){
                                    print("debug2")
                                    if let picURL = (picData as AnyObject).value(forKey: "url"){
                                        print("debug3")
                                        self.imgURLArray.append(picURL as! String)
                                        print(picURL)
                                    }
                                }
                            }
                        }
                    }
                }
                if let page = (JSON! as AnyObject).value(forKey:"paging") as? NSDictionary{
                    if let np = page.value(forKey: "next"){
                        self.nextPage = np as! String
                    }
                    
                }
                
                OperationQueue.main.addOperation({
                    self.tbView.reloadData()
                })
            case .failure(let error):
                print(error)
            }
        }
        SwiftSpinner.hide()
    }
    @IBAction func previousPage(_ sender: Any) {
        SwiftSpinner.show("loading data...")
        if self.prePage != "" {
            nameArray = []
            imgURLArray = []
            idArray = []
            self.nextButton.isEnabled = true
            Alamofire.request(self.prePage).validate().responseJSON {
                response in
                switch response.result {
                case .success:
                    print("Page Validation Successful")
                    let JSON = response.result.value
                    print((JSON! as AnyObject).value(forKey:"data") as Any)
                    print("second time")
                    if let userArray = (JSON! as AnyObject).value(forKey:"data") as? NSArray {
                        for user in userArray{
                            if let userDict = user as? NSDictionary {
                                if let name = userDict.value(forKey: "name") {
                                    self.nameArray.append(name as! String)
                                    print(name)
                                }
                                if let id = userDict.value(forKey: "id") {
                                    self.idArray.append(id as! String)
                                    print(id)
                                }
                                if let picArray = userDict.value(forKey: "picture"){
                                    print("debug1")
                                    if let picData = (picArray as AnyObject).value(forKey: "data"){
                                        print("debug2")
                                        if let picURL = (picData as AnyObject).value(forKey: "url"){
                                            print("debug3")
                                            self.imgURLArray.append(picURL as! String)
                                            print(picURL)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if let page = (JSON! as AnyObject).value(forKey:"paging") as? NSDictionary{
                        if let np = page.value(forKey: "next"){
                            self.nextPage = np as! String
                        }else{
                            self.nextPage = ""
                        }
                        
                        if let pp = page.value(forKey: "previous"){
                            self.prePage = pp as! String
                        }else{
                            self.prePage = ""
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        self.tbView.reloadData()
                    })
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            self.preButton.isEnabled = false
        }
        SwiftSpinner.hide()
    }
    @IBAction func nextPage(_ sender: Any) {
        SwiftSpinner.show("loading data...")
        if self.nextPage != "" {
            nameArray = []
            imgURLArray = []
            idArray = []
            self.preButton.isEnabled = true
            Alamofire.request(self.nextPage).validate().responseJSON {
                response in
                switch response.result {
                case .success:
                    print("Page Validation Successful")
                    let JSON = response.result.value
                    print((JSON! as AnyObject).value(forKey:"data") as Any)
                    print("second time")
                    if let userArray = (JSON! as AnyObject).value(forKey:"data") as? NSArray {
                        for user in userArray{
                            if let userDict = user as? NSDictionary {
                                if let name = userDict.value(forKey: "name") {
                                    self.nameArray.append(name as! String)
                                    print(name)
                                }
                                if let id = userDict.value(forKey: "id") {
                                    self.idArray.append(id as! String)
                                    print(id)
                                }
                                if let picArray = userDict.value(forKey: "picture"){
                                    print("debug1")
                                    if let picData = (picArray as AnyObject).value(forKey: "data"){
                                        print("debug2")
                                        if let picURL = (picData as AnyObject).value(forKey: "url"){
                                            print("debug3")
                                            self.imgURLArray.append(picURL as! String)
                                            print(picURL)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    if let page = (JSON! as AnyObject).value(forKey:"paging") as? NSDictionary{
                        if let np = page.value(forKey: "next"){
                            self.nextPage = np as! String
                        }else{
                            self.nextPage = ""
                        }
                        
                        if let pp = page.value(forKey: "previous"){
                            self.prePage = pp as! String
                        }else{
                            self.prePage = ""
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        self.tbView.reloadData()
                    })
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            self.nextButton.isEnabled = false
        }
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
        if let nameLabel = cell.viewWithTag(200) as? UILabel{
            nameLabel.text = name
        }
        let imgurl = NSURL(string: url)
        let imageView = cell.viewWithTag(201) as! UIImageView
        if let data = NSData(contentsOf: (imgurl as URL?)!) {
            imageView.image = UIImage(data: data as Data)
        }
        
        let identity = idArray[indexPath.row]
        
        var flag = false
        for i in 0..<tmpfavoriteID.count {
            if identity == tmpfavoriteID[i]{
                flag = true
            }
        }
        
        if let star = cell.viewWithTag(202) as? UIImageView {
            if flag == true {
                star.image = #imageLiteral(resourceName: "favorite")
            }
            else{
                star.image = #imageLiteral(resourceName: "empty")
            }
        }
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tmpfavoriteID = UserDefaults.standard.array(forKey: "pageFavoriteid") as! [String]
        tbView.reloadData()
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
            barViewControllers.type = "page"
        }
    }

}
