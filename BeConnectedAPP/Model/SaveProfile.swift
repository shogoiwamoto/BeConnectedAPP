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
    var ref:DatabaseReference!
    
    init(userAuthID:String,userName:String) {
        
        self.userAuthID = userAuthID
        self.userName = userName
        
        
        //ログインの時に拾えるuserAuthIDを先頭につけて送信
        //受信時も、userAuthIDから引っ張る
        ref = Database.database().reference().child("profile").childByAutoId()
    }
    
    init(snapShot:DataSnapshot) {
        
        ref = snapShot.ref
        if let value = snapShot.value as? [String:Any] {
            
            userAuthID = value["userAuthID"] as! String
            userName = value["userName"] as! String
        }
    }
    
    
    func saveProfile()  {
        
        ref.setValue(Contents.self)
        UserDefaults.standard.set(ref, forKey: "userAuthID")
    }
    
    
    
    
    
    
    
}
