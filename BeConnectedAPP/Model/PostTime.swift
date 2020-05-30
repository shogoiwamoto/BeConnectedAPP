//
//  PostTime.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/29.
//

import Foundation


class postTime {
    
    var userImage:String = ""
    var userName:String = ""
    var likeYoutuber:String = ""
    var uID:String = ""
    var userAuthID:String = ""
    
    
    init(userImage:String,userName:String,likeYoutuber:String,uID:String,userAuthID:String) {
        
        self.userImage = userImage
        self.userName = userName
        self.likeYoutuber = likeYoutuber
        self.uID = uID
        self.userAuthID = userAuthID
    }
    
    
}
