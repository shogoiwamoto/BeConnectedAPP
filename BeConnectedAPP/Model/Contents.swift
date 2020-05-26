//
//  Account.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/23.
//

import Foundation

class Contents {
    
    var userImage:String = ""
    var userName:String = ""
    var likeYoutuberText:String = ""
    
    //UID追加
    var uID:String = ""
    
    //SNS画面投稿日時
    var postDateString:String = ""
    
    
    //画面遷移後、データのURLを取得する
    
    init(userImage:String,userName:String,likeYoutuberText:String,uID:String,postDateString:String) {
        
        self.userImage = userImage
        self.userName = userName
        self.likeYoutuberText = likeYoutuberText
        self.uID = uID
        self.postDateString = postDateString
        
    }
    
    
    
    
}
