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
    
    var userImage = UIImage()
    var userImageData = Data()
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //アイコン画像を呼び出して反映する
        if UserDefaults.standard.object(forKey: "userImage") != nil {
            
            userImageData = UserDefaults.standard.object(forKey: "userImage") as! Data
            
            userImage = UIImage(data: userImageData)!
            
            
        }
        
        userImageView.image = userImage

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func postAction(_ sender: Any) {
        
        var timeLineDB:DatabaseReference
        timeLineDB = Database.database().reference().child("timeLine").childByAutoId()
        
        let key = timeLineDB.child("Contents").childByAutoId().key
        
        //画像のデータは取ってくる
        
        //キーバリュー型で送信
        let postinfo = ["comment":self.commentTextView as Any,"postDate":ServerValue.timestamp() as! [String:Any]]
        
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
