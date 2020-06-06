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
    var dataArray = [Contents]()
    
    
    var userImage = String()
    var userName = String()
    var likeYoutuber = String()
    var uID = String()
    var userAuthID = String()
    
    var emailText:String = ""
    var passwordText:String = ""
    
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         
        /*
         
         
        
        
        //アイコン画像を呼び出して反映する
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            
            userImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            
            userImage2 = UIImage(data: userImageData)!
            
            
        }
        
        userImageView.image = userImage2
     */
     
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        
        fetchUserData()
        
        /*
         
        
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
                
            
                let childSnapShot = child as! AnyObject
                
                
                let userName = childSnapShot.value(forKey: "userName")
                let userImage = childSnapShot.value(forKey: "userImage")
                let likeYoutuber = childSnapShot.value(forKey: "likeYotuber")
                
                let uID = childSnapShot.value(forKey: "uID")
                let userAuthID = childSnapShot.value(forKey: "userAuthID")
                
                self.userImageView.image = userImage as! UIImage
                
                //dataArrayに入る
                self.dataArray.append(childSnapShot as! String)
                
                print(self.dataArray.debugDescription)
                print("shogo")
            }
        }
        
        
        
        
    }
    
    /*
     ref.child("profile").observe(.value) { (snapshot) in
         
         for child in snapshot.children {
             
         
             let childSnapShot = child as! DataSnapshot
             
             //dataArrayに入る
             self.dataArray.append(childSnapShot as! String)
             print(self.dataArray.debugDescription)
             
         }
     }
     
     
     */
    
    
    */
    }
    
    
    @IBAction func postAction(_ sender: Any) {
        
        
        userImage = dataArray[0].userImage
        userName = dataArray[0].userName
        likeYoutuber = dataArray[0].likeYoutuber
        
        var timeLineDB = Database.database().reference().child("Music")
        
        //let senduserImage = dataArray[1].userImage as! String
        
        
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
        
        
        
        //navigationで戻る
        //self.navigationController?.popViewController(animated: true)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        commentTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return true
    }
    
        
    func fetchUserData() {
        

        print(Auth.auth().currentUser!.uid)
        
        self.ref.observe(.value) { (snapshot) in

            
            self.ref = snapshot.ref
            
 
            var testkey = Auth.auth().currentUser!.uid

         
            //そのパスで取得できるようにする
            //self.ref.child(testkey).observe(.value) { (snapshots) in
              
            self.ref.child("profile").child(testkey).observe(.value) { (snapshots) in
                
                print("shogo")
                print(snapshots)

                    

                if let value = snapshots.value as? [String:Any] {


                    var userAuthID = (value["userAuthID"] as? String)!
                    var userName = (value["userName"] as? String)!
                    print(userAuthID)
                    print(userName)
                    
                    var userImage = (value["userImage"] as? String)!
                    var likeYoutuber = (value["likeYoutuber"] as? String)!
                    //self.uID = (value["uID"] as? String)!
                    print(userImage)
                    print(likeYoutuber)
                    
                    //self.userImageView.image = self.userImage as? UIImage
                    self.dataArray.append(Contents(userImage: userImage, userName: userName, likeYoutuber: likeYoutuber, userAuthID: userAuthID))
                    
                    print(self.dataArray.debugDescription)
                    
                    

                }

            }
            
            

        }

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
