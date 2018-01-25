//
//  DetailTabBarController.swift
//  FBSearch
//
//  Created by Yang Cao on 2017/4/24.
//  Copyright © 2017年 Yang Cao. All rights reserved.
//
import FBSDKShareKit
import FBSDKLoginKit
import FBSDKCoreKit
import EasyToast
import UIKit

class DetailTabBarController: UITabBarController, FBSDKSharingDelegate {
    var name:String = ""
    var img:String = ""
    var id:String = ""
    var type:String = ""
    
    let localstorage = UserDefaults.standard
    
    @IBOutlet weak var optionButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func showMenu(_ sender: Any) {
        var favoriteStr = ""
        if isFavorite(){
            favoriteStr = "Removing From Favorite"
        }
        else{
            favoriteStr = "Add Favorite"
        }
        let alertActionSheet = UIAlertController(title: "Menu", message: "", preferredStyle: .actionSheet)
        
        let addAction = UIAlertAction(title: favoriteStr, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            if self.isFavorite(){
                self.removeFavorite()
            }
            else{
                self.addFavorite()
            }
        })
        
        let shareAction = UIAlertAction(title: "Share", style: .default, handler: {(alert:UIAlertAction!) -> Void in self.share()})
        let closeAction = UIAlertAction(title: "Close", style: .destructive, handler: nil)
        
        
        alertActionSheet.addAction(addAction)
        alertActionSheet.addAction(shareAction)
        alertActionSheet.addAction(closeAction)
        self.present(alertActionSheet, animated: true, completion: nil)
    }
    
    func share(){
        let myshare : FBSDKShareLinkContent = FBSDKShareLinkContent()
        myshare.contentTitle = self.name
        myshare.imageURL = URL(string: self.img)
        myshare.contentDescription = "FB Share From CSCI571HW9"
    
        FBSDKShareDialog.show(from: self, with: myshare, delegate: self)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        self.view.showToast("Share with error", position: .bottom, popTime: 2, dismissOnTap: true)
    }
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        if results.count > 0{
            self.view.showToast("Shared!", position: .bottom, popTime: 2, dismissOnTap: true)
        }
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        self.view.showToast("Cancel share!", position: .bottom, popTime: 2, dismissOnTap: true)
    }
    
    func isFavorite() -> Bool {
        var idList = [String]()
        if type == "user" {
            idList = UserDefaults.standard.array(forKey: "userFavoriteid") as! [String]
            return helper(idList:idList)
        }
        
        else if type == "page" {
            idList = UserDefaults.standard.array(forKey: "pageFavoriteid") as! [String]
            return helper(idList:idList)
        }
        
        else if type == "place" {
            idList = UserDefaults.standard.array(forKey: "placeFavoriteid") as! [String]
            return helper(idList:idList)
        }
        
        else if type == "group" {
            idList = UserDefaults.standard.array(forKey: "groupFavoriteid") as! [String]
            return helper(idList:idList)
        }
        
        else if type == "event" {
            idList = UserDefaults.standard.array(forKey: "eventFavoriteid") as! [String]
            return helper(idList:idList)
        }
        
        return false
    }
    
    func helper(idList:[String]) -> Bool {
        for i in 0..<idList.count {
            if id == idList[i]{
                return true
            }
        }
        return false
    }
    
    func addFavorite(){
        print(type)
        if type == "user" {
            print("add favorite!")
            var idList = self.localstorage.array(forKey: "userFavoriteid") as! [String]
            idList.append(id)
            localstorage.set(idList, forKey: "userFavoriteid")
            
            var urlList = self.localstorage.array(forKey: "userFavoriteurl") as! [String]
            urlList.append(img)
            localstorage.set(urlList, forKey: "userFavoriteurl")
            
            var nameList = self.localstorage.array(forKey: "userFavoritename") as! [String]
            nameList.append(name)
            localstorage.set(nameList, forKey: "userFavoritename")
        }
        
        if type == "page" {
            print("add favorite!")
            var idList = self.localstorage.array(forKey: "pageFavoriteid") as! [String]
            idList.append(id)
            localstorage.set(idList, forKey: "pageFavoriteid")
            
            var urlList = self.localstorage.array(forKey: "pageFavoriteurl") as! [String]
            urlList.append(img)
            localstorage.set(urlList, forKey: "pageFavoriteurl")
            
            var nameList = self.localstorage.array(forKey: "pageFavoritename") as! [String]
            nameList.append(name)
            localstorage.set(nameList, forKey: "pageFavoritename")
        }
        
        if type == "place" {
            print("add favorite!")
            var idList = self.localstorage.array(forKey: "placeFavoriteid") as! [String]
            idList.append(id)
            localstorage.set(idList, forKey: "placeFavoriteid")
            
            var urlList = self.localstorage.array(forKey: "placeFavoriteurl") as! [String]
            urlList.append(img)
            localstorage.set(urlList, forKey: "placeFavoriteurl")
            
            var nameList = self.localstorage.array(forKey: "placeFavoritename") as! [String]
            nameList.append(name)
            localstorage.set(nameList, forKey: "placeFavoritename")
        }
        
        if type == "group" {
            print("add favorite!")
            var idList = self.localstorage.array(forKey: "groupFavoriteid") as! [String]
            idList.append(id)
            localstorage.set(idList, forKey: "groupFavoriteid")
            
            var urlList = self.localstorage.array(forKey: "groupFavoriteurl") as! [String]
            urlList.append(img)
            localstorage.set(urlList, forKey: "groupFavoriteurl")
            
            var nameList = self.localstorage.array(forKey: "groupFavoritename") as! [String]
            nameList.append(name)
            localstorage.set(nameList, forKey: "groupFavoritename")
        }
        
        if type == "event" {
            print("add favorite!")
            var idList = self.localstorage.array(forKey: "eventFavoriteid") as! [String]
            idList.append(id)
            localstorage.set(idList, forKey: "eventFavoriteid")
            
            var urlList = self.localstorage.array(forKey: "eventFavoriteurl") as! [String]
            urlList.append(img)
            localstorage.set(urlList, forKey: "eventFavoriteurl")
            
            var nameList = self.localstorage.array(forKey: "eventFavoritename") as! [String]
            nameList.append(name)
            localstorage.set(nameList, forKey: "eventFavoritename")
        }
        
    }
    
    func removeFavorite(){
        if type == "user" {
            print("remove favorite!")
            var idList = self.localstorage.array(forKey: "userFavoriteid") as! [String]
            var urlList = self.localstorage.array(forKey: "userFavoriteurl") as! [String]
            var nameList = self.localstorage.array(forKey: "userFavoritename") as! [String]
            //let index = findIndex(idArr:idArr,id:id)
            var index = 0
            for i in 0..<idList.count {
                if idList[i] == id{
                    index = i
                }
            }
            idList.remove(at: index)
            localstorage.set(idList, forKey: "userFavoriteid")
            urlList.remove(at: index)
            localstorage.set(urlList, forKey: "userFavoriteurl")
            nameList.remove(at: index)
            localstorage.set(nameList, forKey: "userFavoritename")
        }
        
        if type == "page" {
            print("remove favorite!")
            var idList = self.localstorage.array(forKey: "pageFavoriteid") as! [String]
            var urlList = self.localstorage.array(forKey: "pageFavoriteurl") as! [String]
            var nameList = self.localstorage.array(forKey: "pageFavoritename") as! [String]
            //let index = findIndex(idArr:idArr,id:id)
            var index = 0
            for i in 0..<idList.count {
                if idList[i] == id{
                    index = i
                }
            }
            idList.remove(at: index)
            localstorage.set(idList, forKey: "pageFavoriteid")
            urlList.remove(at: index)
            localstorage.set(urlList, forKey: "pageFavoriteurl")
            nameList.remove(at: index)
            localstorage.set(nameList, forKey: "pageFavoritename")
        }
        
        if type == "place" {
            print("remove favorite!")
            var idList = self.localstorage.array(forKey: "placeFavoriteid") as! [String]
            var urlList = self.localstorage.array(forKey: "placeFavoriteurl") as! [String]
            var nameList = self.localstorage.array(forKey: "placeFavoritename") as! [String]
            //let index = findIndex(idArr:idArr,id:id)
            var index = 0
            for i in 0..<idList.count {
                if idList[i] == id{
                    index = i
                }
            }
            idList.remove(at: index)
            localstorage.set(idList, forKey: "placeFavoriteid")
            urlList.remove(at: index)
            localstorage.set(urlList, forKey: "placeFavoriteurl")
            nameList.remove(at: index)
            localstorage.set(nameList, forKey: "placeFavoritename")
        }
        
        if type == "group" {
            print("remove favorite!")
            var idList = self.localstorage.array(forKey: "groupFavoriteid") as! [String]
            var urlList = self.localstorage.array(forKey: "groupFavoriteurl") as! [String]
            var nameList = self.localstorage.array(forKey: "groupFavoritename") as! [String]
            //let index = findIndex(idArr:idArr,id:id)
            var index = 0
            for i in 0..<idList.count {
                if idList[i] == id{
                    index = i
                }
            }
            idList.remove(at: index)
            localstorage.set(idList, forKey: "groupFavoriteid")
            urlList.remove(at: index)
            localstorage.set(urlList, forKey: "groupFavoriteurl")
            nameList.remove(at: index)
            localstorage.set(nameList, forKey: "groupFavoritename")
        }
        
        if type == "event" {
            print("remove favorite!")
            var idList = self.localstorage.array(forKey: "eventFavoriteid") as! [String]
            var urlList = self.localstorage.array(forKey: "eventFavoriteurl") as! [String]
            var nameList = self.localstorage.array(forKey: "eventFavoritename") as! [String]
            //let index = findIndex(idArr:idArr,id:id)
            var index = 0
            for i in 0..<idList.count {
                if idList[i] == id{
                    index = i
                }
            }
            idList.remove(at: index)
            localstorage.set(idList, forKey: "eventFavoriteid")
            urlList.remove(at: index)
            localstorage.set(urlList, forKey: "eventFavoriteurl")
            nameList.remove(at: index)
            localstorage.set(nameList, forKey: "eventFavoritename")
        }
    }
}
