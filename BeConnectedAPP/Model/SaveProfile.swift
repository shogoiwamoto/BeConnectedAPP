//
//  saveProfile.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/30.
//

import Foundation
import Firebase


class SaveProfile {
    
    
    var userAuthID:String = ""
    var userName:String = ""
    var userImage:String = ""
    var likeYoutuber:String = ""
    var uID:String = ""
    
    
    var ref:DatabaseReference!
    
    init(userAuthID:String,userName:String,userImage:String,likeYoutuber:String,uID:String) {
        
        self.userAuthID = userAuthID
        self.userName = userName
        self.userImage = userImage
        self.likeYoutuber = likeYoutuber
        self.uID = uID
        
        //ログインの時に拾えるuserAuthIDを先頭につけて送信
        //受信時も、userAuthIDから引っ張る
        ref = Database.database().reference().child("profile").childByAutoId()
    }
    
    init(snapShot:DataSnapshot) {
        
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any] {
            
            
            userAuthID = value["userAuthID"] as! String
            userName = value["userName"] as! String
            userImage = value["userImage"] as! String
            likeYoutuber = value["likeYoutuber"] as! String
            uID = value["uID"] as! String
        }
    }
    
    
    func saveProfile()  {
        
        ref.setValue(Contents.self)
        UserDefaults.standard.set(ref, forKey: "userAuthID")
    }
    
    
    
    
    
    
    
}
