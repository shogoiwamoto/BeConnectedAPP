//
//  SNSPage1ViewContoroller.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/28.
//

import UIKit
import SegementSlide
import Firebase
import SDWebImage


class SNSPage1ViewContoroller: UITableViewController,SegementSlideContentScrollViewDelegate {
    

    var userImage = String()
    var userName = String()
    var likeYoutuber = String()
    var uID = String()
    var comment = String()
    
    
    //Postする時に使う
    var passedimage = UIImage()
    
    
    
    
    var contentsArray = [postTime]()
    
    var ref2 = Database.database().reference()
    
    var id = String()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        //可変の自動設定
        tableView.rowHeight = UITableView.automaticDimension
        
        
        tableView.estimatedRowHeight = 130
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        //navigationController?.setNavigationBarHidden(true, animated: true)
        
        //fetchContentsData()
        
        //テスト
        featcData()
        
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
        
        let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        //
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        //cell.userImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].userImage), completed: nil)
        
        //cell.userNameLabel.text = contentsArray[indexPath.row].userName
        //cell.likeYoutuberLabel.text = contentsArray[indexPath.row].likeYoutuber
        //cell.commentLabel.text = contentsArray[indexPath.row].comment
        
        //DBから受信したコンテンツを表示する
        //Tagで管理
        
         
        //アイコン画像
        let userImageView = cell.viewWithTag(1) as! UIImageView
        userImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].userImage), completed: nil)
        
        userImageView.layer.cornerRadius = 30
        print(userImageView)
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
        return view.frame.size.height/3.5
    }
    
    
    /*
    
    func fetchContentsData() {
        
        //データを引っ張るところから
        var ref = Database.database().reference().child("Peace").observe(.value) { (snapshot) in
            
            
            //.queryLimited(toLast: 100).queryOrdered(byChild: "postDate")
            
            //値を空にする
            self.contentsArray.removeAll()
            
            //Datan
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshot {
                    
                    print("チェック")
                    print(snapshot)
                    
                    //ディクショナリー型で値をpostDataに入れる
                    if let postData = snap.value as? [String:Any] {
                        
                        let userName = postData["userName"] as? String
                        
                        print("確認")
                        print(userName)
                        let userImage = postData["userImage"] as? String
                        let likeyoutuber = postData["likeYoutuber"] as? String
                        let comment = postData["comment"] as? String
                        //let uID = postData["uID"] as? String
                        //let userAuthID = postData["userAuthID"] as? String
                        
                        //let postDate = postData["postDate"] as? CLong
                        
                        //let timeString = self.convertTimeStamp(serverTimeStamp: postDate!)
                        
                        self.contentsArray.append(postTime(userImage: userImage!, userName: userName!, likeYoutuber: likeyoutuber!, comment: comment!))
                        
                        print(self.contentsArray.debugDescription)
                        
                        
                    }
            }
            
                //self.SNSTimeLine.reloadData()
                
                
            
                //タイムラインの最新の投稿をい取得する
                /*
                 
                let indexPath = IndexPath(row: self.contentsArray.count - 1, section: 0)
                
                if self.contentsArray.count >= 5 {
                    
                    self.SNSTimeLine.scrollToRow(at: indexPath, at: .bottom, animated: true)
                    
                    
                }
                 */
            
                
        }
        //self.SNSTimeLine.reloadData()
      }
    }
 
 */
    
    
    func featcData() {
        
       var reference = Database.database().reference().child("Music").observe(.value) { (snapshot) in
    
            print("投稿情報取得")
            print(snapshot)
        
        self.contentsArray.removeAll()
        

            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshot {
                    
                    if let postData = snap.value as? [String:Any] {
                    
                
                
                    let userName = (postData["userName"] as? String)!
                    let userImage = (postData ["userImage"] as? String)!
                    let likeYoutuber = (postData["likeYoutuber"] as? String)!
                    let comment = (postData["comment"] as? String)!
                    //let postDate = postData["postDate"] as? CLong
                        
                    //let timeString = self.convertTimeStamp(serverTimeStamp: postDate!)
                
                    print("確認")
                    print(userName)
                
                    self.contentsArray.append(postTime(userImage: userImage, userName: userName, likeYoutuber: likeYoutuber,
                                                       comment: comment))
                        
                    }
                }
        
            }
        
        self.tableView.reloadData()
        
        }
    }
    
    
    
    func convertTimeStamp(serverTimeStamp:CLong)->String {
        
        //時間を変換する
        let x = serverTimeStamp/1000
        let date = Date(timeIntervalSince1970: TimeInterval(x))
        let formatter = DateFormatter()
        
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        return formatter.string(from: date)
        
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
