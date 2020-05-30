//
//  PostViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/28.
//

import UIKit
import Firebase
import SDWebImage

class PostViewController: UIViewController {
    
    
    var passedImage = UIImage()
    
    var userImage2 = UIImage()
    var userImageData = Data()
    
    //データを取ってくる
    var ref = Database.database().reference()
    var dataArray = [String]()
    
    
    var userImage = String()
    var userName = String()
    var likeYoutuber = String()
    var uID = String()
    var userAuthID = String()
    
    
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //アイコン画像を呼び出して反映する
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            
            userImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            
            userImage2 = UIImage(data: userImageData)!
            
            
        }
        
        userImageView.image = userImage2

        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(true)
        
        
        Auth.auth().signInAnonymously { (result, error) in
            
            if error == nil {
                
                guard let user = result?.user else { return }
                
                let userAuthID = user.uid
                var saveProfile = SaveProfile(userAuthID: userAuthID, userName: self.userName)
                saveProfile.saveProfile()
                self.dismiss(animated: true, completion: nil)
                
            } else {
                
                //アラート
                print(error?.localizedDescription as Any)
                
                
            }
            
        }
        
        
        ref.child("profile").child("userAuthID").observe(.value) { (snapshot) in
            
            for child in snapshot.children {
                
            
                let childSnapShot = child as! DataSnapshot
                
                //dataArrayに入る
                self.dataArray.append(childSnapShot as! String)
                
            }
        }
        
    }
    
    
    
    
    
    @IBAction func postAction(_ sender: Any) {
        
        
        
        var timeLineDB:DatabaseReference
        timeLineDB = Database.database().reference().child("Music").childByAutoId()
    
        
        //キーバリュー型で送信
        //userImageなども値を取得後に追加する
        let postinfo = ["userImage":self.userImage as Any,"userName":self.userName as Any,"likeYoutuber":self.likeYoutuber as Any,"comment":self.commentTextView as Any,"postDate":ServerValue.timestamp() as! [String:Any]]
        
        //DBに送信
        timeLineDB.updateChildValues(postinfo)
        
        //navigationで戻る
        self.navigationController?.popViewController(animated: true)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
