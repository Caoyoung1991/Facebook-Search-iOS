//
//  PostViewController.swift
//  FBSearch
//
//  Created by Yang Cao on 2017/4/23.
//  Copyright © 2017年 Yang Cao. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner

class PostViewController: UITableViewController {
    var text:String = ""
    var img:String = ""
    var messageArray = [String]()
    var timeArray = [String]()
    
    @IBOutlet weak var postView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("loading data...")
        postView.estimatedRowHeight = 44.0
        postView.rowHeight = UITableViewAutomaticDimension
        self.postView.tableFooterView = UIView(frame: CGRect.zero)
        Alamofire.request("http://sample-env.xyhsmeh2ph.us-west-2.elasticbeanstalk.com/", parameters: ["id": text]).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                print("Validation Successful")
                let JSON = response.result.value
                //print((JSON! as AnyObject).value(forKey:"albums"))
                print("No.1000")
                if let albumDict = (JSON! as AnyObject).value(forKey:"posts") as? NSDictionary {
                    //print("No.100")
                    if let dataArray = albumDict.value(forKey:"data") as? NSArray{
                        print("No.10000")
                        for user in dataArray{
                            if let userDict = user as? NSDictionary {
                                print("No.20000")
                                if let message = userDict.value(forKey: "message") {
                                    self.messageArray.append(message as! String)
                                    //print(name)
                                }
                                if let time = userDict.value(forKey: "created_time") {
                                    self.timeArray.append(time as! String)
                                }
                            }
                        }
                    }
                }
                OperationQueue.main.addOperation({
                    self.postView.reloadData()
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "postCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! postCell
        
        let message = messageArray[indexPath.row] as String
        cell.postContent.text = message
        
        let time = timeArray[indexPath.row] as String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+0000"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let date = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.local
        let timeStamp = dateFormatter.string(from: date!)
        cell.postTime.text = timeStamp
        
        let imgurl = NSURL(string: img)
        let imageView = cell.postImage
        if let data = NSData(contentsOf: (imgurl as URL?)!) {
            imageView?.image = UIImage(data: data as Data)
        }
        
        return cell;
    }

}
