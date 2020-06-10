//
//  PostViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/28.
//

import UIKit
import Firebase
import SDWebImage

class GamePostViewController: UIViewController {
    
    
    var passedImage = UIImage()
    
    var userImage2 = UIImage()
    var userImageData = Data()
    
    //データを取ってくる
    //var ref = Database.database().reference()
    //var dataArray = [Contents]()
    
    var postArray = [postTime]()
    
    
    var userImage = String()
    var userName = String()
    var likeYoutuber = String()
    var uID = String()
    var userAuthID = String()
    
    
    
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        //URL型をキャストする
        //userImageView.sd_setImage(with: URL(string: dataArray[0].userImage), completed: nil)
            //sd_setImage(with: URL(string: dataArray[0].userImage), completed: nil)
        
        
        //アイコン画像を呼び出して反映する
        if UserDefaults.standard.object(forKey: "userImageicon") != nil {
            
            userImageData = UserDefaults.standard.object(forKey: "userImageicon") as! Data
            
            userImage2 = UIImage(data: userImageData)!
            userImageView.image = userImage2
            
            
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            likeYoutuber = UserDefaults.standard.object(forKey: "likeYoutuber") as! String
            userImage = UserDefaults.standard.object(forKey: "passurl") as! String
            
        }
        
        
        
        //fetchUserData()
        
        userImageView.layer.cornerRadius = 30
        shareButton.layer.cornerRadius = 20
        
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
        
        //userImage = dataArray[0].userImage
        //userName = dataArray[0].userName
        //likeYoutuber = dataArray[0].likeYoutuber
        
        
        
        
        var timeLineDB = Database.database().reference().child("Game").childByAutoId()
        
        //キーバリュー型で送信
        //userImageなども値を取得後に追加する
        let postinfo = ["userImage":self.userImage as Any,"userName":self.userName as Any,"likeYoutuber":self.likeYoutuber as Any,"comment":self.commentTextView.text as Any]// as [String:Any]
        
        //"postDate":ServerValue.timestamp()
        
                timeLineDB.updateChildValues(postinfo)
        
                self.commentTextView.text = ""
        
        self.dismiss(animated: true, completion: nil)
        
        
        //let senduserImage = dataArray[1].userImage as! String
        /*
         
         
        
        let storage = Storage.storage().reference(forURL: "gs://fanconnect-15235.appspot.com")
        
        //画像が入るフォルダ
        let key = timeLineDB.child("PostImage").childByAutoId().key
        
        let imageRef = storage.child("PostImage").child("\(String(describing: key!)).jpeg")
        
        //画像送信準備
        var userprofileImageData:Data = Data()
        
        //画像→Data型になっている
        if self.userImageView.image != nil {
            
            userprofileImageData = (self.userImageView.image?.jpegData(compressionQuality: 0.01))!
            
            
        }
        
        
        let uploadTask = imageRef.putData(userprofileImageData, metadata: nil) {
        (metaData,error) in
        
            if error != nil {
            
                print(error)
                return
                
            }
            
            imageRef.downloadURL { (url, error) in
            
                if url != nil {
        
        //キーバリュー型で送信
        //userImageなども値を取得後に追加する
                    let postinfo = ["userImage":url?.absoluteString as Any,"userName":self.userName as Any,"likeYoutuber":self.likeYoutuber as Any,"comment":self.commentTextView.text as Any]// as [String:Any]
        
        //"postDate":ServerValue.timestamp()
        
                    timeLineDB.updateChildValues(postinfo)
        
                    self.commentTextView.text = ""
        
                    
                }
            }
        }
    
    */
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        commentTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return true
    }
    
    /*
     
    
    func fetchUserData() {
        
        //dataArray.removeAll()
        

        print(Auth.auth().currentUser!.uid)
        
        self.ref.observe(.value) { (snapshot) in

            
            self.ref = snapshot.ref
            
 
            var testkey = Auth.auth().currentUser!.uid

         
            //そのパスで取得できるようにする
            //self.ref.child(testkey).observe(.value) { (snapshots) in
              
            self.ref.child("profile").child(testkey).observe(.value) { (snapshots) in
                
                print("アカウント情報取得")
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
                    
                    //アイコン表示
                    //self.userImageView.sd_setImage(with: URL(string: userImage), completed: nil)
                    
                    //self.userImageView.image = self.userImage as? UIImage
                    self.dataArray.append(Contents(userImage: userImage, userName: userName, likeYoutuber: likeYoutuber, userAuthID: userAuthID))
                    
                    print("dataArrayにて配列型に")
                    print(self.dataArray.debugDescription)
                    
                    

                }

            }
            
            

        }

    }
 
  */



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
