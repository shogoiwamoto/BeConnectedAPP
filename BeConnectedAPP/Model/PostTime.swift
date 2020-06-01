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
    var postDate:String = ""
    var comment:String = ""

    
    
    init(userImage:String,userName:String,likeYoutuber:String,postDate:String,comment:String) {
        
        self.userImage = userImage
        self.userName = userName
        self.likeYoutuber = likeYoutuber
        self.postDate = postDate
        self.comment = comment
    }
    
    
}
