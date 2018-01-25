//
//  DetailViewController.swift
//  FBSearch
//
//  Created by Yang Cao on 2017/4/23.
//  Copyright © 2017年 Yang Cao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class DetailViewController: UITableViewController {
    var text:String = ""
    var imageString:String!
    var nameArray = [String]()
    var pictureArray1 = [String]()
    var pictureArray2 = [String]()
    
    @IBOutlet weak var expandView: UITableView!
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("loading data...")
        updateUI()
        self.expandView.tableFooterView = UIView(frame: CGRect.zero)
        Alamofire.request("http://sample-env.xyhsmeh2ph.us-west-2.elasticbeanstalk.com/", parameters: ["id": text]).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                print("Validation Successful")
                let JSON = response.result.value
                //print((JSON! as AnyObject).value(forKey:"albums"))
                print("No.10")
                if let albumDict = (JSON! as AnyObject).value(forKey:"albums") as? NSDictionary {
                    //print("No.100")
                    if let dataArray = albumDict.value(forKey:"data") as? NSArray{
                        //print("No.1")
                        for user in dataArray{
                            if let userDict = user as? NSDictionary {
                                //print("No.2")
                                if let name = userDict.value(forKey: "name") {
                                    self.nameArray.append(name as! String)
                                    print(name)
                                }
                                if let photosDict = userDict.value(forKey:"photos") as? NSDictionary{
                                    if let dotaArray = photosDict.value(forKey:"data") as? NSArray{
                                        //print("No.3")
                                        //for pic in dotaArray{
                                            if let picDict1 = dotaArray[0] as? NSDictionary{
                                                //print("No.4")
                                                //print(picDict1)
                                                if let picURL = picDict1.value(forKey: "picture"){
                                                     //print("No.5")
                                                     self.pictureArray1.append(picURL as! String)
                                                     //print(picURL)
                                                }
                                            }
                                            if let picDict2 = dotaArray[1] as? NSDictionary{
                                                if let picURL = picDict2.value(forKey: "picture"){
                                                    self.pictureArray2.append(picURL as! String)
                                                    //print(picURL)
                                                }
                                            }
                                        //}
                                    }
                                }
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation({
                    self.expandView.reloadData()
                })
            case .failure(let error):
                print(error)
            }
        }
        SwiftSpinner.hide()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUI() {
        print(text)
        //let imgURL = URL(string:imageString)
        //self.named.text = imageString
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count;
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(selectedIndex == indexPath.row) {
            return 400;
            //return self.calculateHeight(selectedIndexPath: indexPath)
        } else {
            return 40;
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! customCell

        let name = nameArray[indexPath.row] as String
        cell.firstLabelView.text = name
        
        let url1 = pictureArray1[indexPath.row] as String
        let url2 = pictureArray2[indexPath.row] as String
        
        let imgurl1 = NSURL(string: url1)
        let imageView1 = cell.pictureView1!
        if let data1 = NSData(contentsOf: (imgurl1 as URL?)!) {
            imageView1.image = UIImage(data: data1 as Data)
        }
        
        let imgurl2 = NSURL(string: url2)
        let imageView2 = cell.pictureView2!
        if let data2 = NSData(contentsOf: (imgurl2 as URL?)!) {
            imageView2.image = UIImage(data: data2 as Data)
        }
        print("it's here")
        return cell;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(selectedIndex == indexPath.row) {
            selectedIndex = -1
        } else {
            selectedIndex = indexPath.row
        }
        self.expandView.beginUpdates()
        self.expandView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic )
        self.expandView.endUpdates()
    }
}
