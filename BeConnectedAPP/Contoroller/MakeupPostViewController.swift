//
//  MakeupPostViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/06/09.
//

import UIKit
import Firebase
import SDWebImage

class MakeupPostViewController: UIViewController {
    
    var userImage2 = UIImage()
    var userImageData = Data()
    
    var userImage = String()
    var userName = String()
    var likeYoutuber = String()
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //アイコン画像を呼び出して反映する
        if UserDefaults.standard.object(forKey: "userImageicon") != nil {
            
            userImageData = UserDefaults.standard.object(forKey: "userImageicon") as! Data
            
            userImage2 = UIImage(data: userImageData)!
            userImageView.image = userImage2
            
            
            userName = UserDefaults.standard.object(forKey: "userName") as! String
            likeYoutuber = UserDefaults.standard.object(forKey: "likeYoutuber") as! String
            userImage = UserDefaults.standard.object(forKey: "passurl") as! String
            
        }
        userImageView.layer.cornerRadius = 30
        shareButton.layer.cornerRadius = 20
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func MakeupPostAction(_ sender: Any) {
       
    var timeLineDB = Database.database().reference().child("Makeup").childByAutoId()
    
    //キーバリュー型で送信
    //userImageなども値を取得後に追加する
    let postinfo = ["userImage":self.userImage as Any,"userName":self.userName as Any,"likeYoutuber":self.likeYoutuber as Any,"comment":self.commentTextView.text as Any]// as [String:Any]
    
    //"postDate":ServerValue.timestamp()
    
        timeLineDB.updateChildValues(postinfo)
    
        self.commentTextView.text = ""
    
        self.dismiss(animated: true, completion: nil)
        
        
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
