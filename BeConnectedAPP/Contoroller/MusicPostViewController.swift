//
//  MusicPostViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/06/05.
//

import UIKit
import Firebase
import Alamofire

class MusicPostViewController: UIViewController {
    
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
    
    var emailText:String = ""
    var passwordText:String = ""
    

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var musicSendButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (result, error) in
            
            
            if error == nil {
                
                guard let user = result?.user else { return }
                
                let userAuthID = user.uid
                var saveProfile = SaveProfile(userAuthID:  userAuthID, userName: self.userName, userImage: self.userImage, likeYoutuber: self.likeYoutuber,uID: self.uID)
                saveProfile.saveProfile()
                
                print(saveProfile)
                //self.dismiss(animated: true, completion: nil)
                
                
            } else {
                
                //アラート
                print(error?.localizedDescription as Any)
                print("AuthID取得失敗")
                
                
            }
            
        }
        
        
        ref.child("profile").observe(.value) { (snapshot) in
            
            for child in snapshot.children {
                
            
                let childSnapShot = child as AnyObject
                
                let userImage = childSnapShot.value(forKey: "userImage")
                let userName = childSnapShot.value(forKey: "userName")
                let likeYoutuber = childSnapShot.value(forKey: "likeYotuber")
                
                let uID = childSnapShot.value(forKey: "uID")
                let userAuthID = childSnapShot.value(forKey: "userAuthID")
                
                //dataArrayに入る
                self.dataArray.append(childSnapShot as! String)
                print(self.dataArray.debugDescription)
                print("shogo")
            }
        }
        
        
        
        
    }
    
    
    @IBAction func musicSendAction(_ sender: Any) {
        
        var timeLineDB = Database.database().reference().child("Music")
        
        //キーバリュー型で送信
        //userImageなども値を取得後に追加する
        let postinfo = ["userImage":self.userImage as Any,"userName":self.userName as Any,"likeYoutuber":self.likeYoutuber as Any,"comment":self.commentTextView.text as Any,"postDate":ServerValue.timestamp() as! [String:Any]]
        
        
        //DBに送信
        timeLineDB.childByAutoId().setValue(postinfo) { (error, result) in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                print("送信完了")
                
                self.commentTextView.text = ""
                
            }
            
            
        }
        
        
    }
    
    
   
    
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        commentTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return true
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
