//
//  SNSPage1ViewContoroller.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/28.
//

import UIKit
import SegementSlide
import Firebase

class SNSPage1ViewContoroller: UITableViewController,SegementSlideContentScrollViewDelegate {

    var userImage = String()
    var userName = String()
    var likeYoutuber = String()
    var uID = String()
    var postDate = String()
    var commnet = String()
    
    //Postする時に使う
    var passedimage = UIImage()
    
    
    
    @IBOutlet weak var SNSTimeLine: UITableView!
    @IBOutlet weak var commentButton: UIButton!
    
    
    var contentsArray = [Contents]()
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //新規登録画面の情報を呼び出す
        
        //情報を呼び出す
        
        // Do any additional setup after loading the view.
        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        
    }
    
    @objc var scrollView: UIScrollView {
        
        return tableView
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //後で追加する
        return contentsArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //後で追加する
        
        let cell = SNSTimeLine.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        
        //DBから受信したコンテンツを表示する
        //Tagで管理
        
        //アイコン画像
        let userImageView = cell.viewWithTag(1) as! UIImageView
        userImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].userImage), completed: nil)
        
        //ユーザー名
        let userNameLabel = cell.viewWithTag(2) as! UILabel
        userNameLabel.text = contentsArray[indexPath.row].userName
        
        //投稿日時
        let postDateLabel = cell.viewWithTag(3) as! UILabel
        postDateLabel.text = contentsArray[indexPath.row].postDate
        
        //好きなYouTuber
        let likeYoutuberLabel = cell.viewWithTag(4) as! UILabel
        likeYoutuberLabel.text = contentsArray[indexPath.row].likeYoutuber
        
        //Yuoubeをみたコメント投稿
        let commentLabel = cell.viewWithTag(5) as! UILabel
        commentLabel.text = contentsArray[indexPath.row].comment
        
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //見直し 要調整
        return view.frame.size.height/6
    }
    
    
    @IBAction func commentAction(_ sender: Any) {
        
        let postVC = self.storyboard?.instantiateViewController(identifier: "post") as! PostViewController
        
        //要編集
        //postVC.passedImage =
        
        //315確認　画面遷移
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    
    
    func fetchContentsData() {
        
        //データを引っ張るところから
        let ref = Database.database().reference().child("Music").queryLimited(toLast: 100).queryOrdered(byChild: "postDate").observe(.value) { (snapshot) in
            
            //値を空にする
            self.contentsArray.removeAll()
            
            
            
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
