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
    var likeYoutuber:String = ""
    
    //uID追加
    var uID:String = ""
    
    //SNS画面投稿日時
    var postDate:String = ""
    
    //投稿コメント
    var comment:String = ""
    
    
    
    //画面遷移後、データのURLを取得する
    
    init(userImage:String,userName:String,likeYoutuber:String,uID:String,postDate:String,comment:String) {
        
        self.userImage = userImage
        self.userName = userName
        self.likeYoutuber = likeYoutuber
        self.uID = uID
        self.postDate = postDate
        self.comment = comment
        
    }
    
    
    
    
}
