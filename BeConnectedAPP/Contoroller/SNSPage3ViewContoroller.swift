//
//  SNSPage3ViewContoroller.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/28.
//

import UIKit
import SegementSlide
import Firebase
import SDWebImage

class SNSPage3ViewContoroller: UITableViewController,SegementSlideContentScrollViewDelegate  {
    
    
    var userImage = String()
    var userName = String()
    var likeYoutuber = String()
    
    var commnet = String()
    
    
    var contentsArray = [postTime]()
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130

           // Do any additional setup after loading the view.
       }
       
       
       override func viewWillAppear(_ animated: Bool) {
               super .viewWillAppear(true)
               
               
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
               
           let cell:CustomCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
           
           //アイコン画像
           let userImageView = cell.viewWithTag(1) as! UIImageView
           userImageView.sd_setImage(with: URL(string: contentsArray[indexPath.row].userImage), completed: nil)
           
           userImageView.layer.cornerRadius = 30
           print(userImageView)
           //ユーザー名
           let userNameLabel = cell.viewWithTag(2) as! UILabel
           userNameLabel.text = contentsArray[indexPath.row].userName
           
           //投稿日時
           //let postDateLabel = cell.viewWithTag(3) as! UILabel
           //postDateLabel.text = contentsArray[indexPath.row].postDate
           
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
    
    func featcData() {
        
       var reference = Database.database().reference().child("Fashion").observe(.value) { (snapshot) in
    
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
