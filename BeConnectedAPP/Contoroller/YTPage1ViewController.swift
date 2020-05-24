//
//  YTPage1ViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/24.
//

import UIKit
import SegementSlide
import Alamofire
import SwiftyJSON
import SDWebImage

class YTPage1ViewController: UITableViewController,SegementSlideContentScrollViewDelegate {
    
    var youtubeData = YouTubeData()
    
    var videoIdArray = [String]()
    var publishedAtArray = [String]()
    var titleArray = [String]()
    var imageURLStringArray = [String]()
    var youtubeURLArray = [String]()
    var channelTitleArray = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @objc var scrollView: UIScrollView {
        
        
        return tableView
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        //選択不可
        cell.selectionStyle = .none
        
        let profileImageURL = URL(string: self.imageURLStringArray[indexPath.row] as String)!
        //SDWebimage
        //cell.imageView?.sd_setImage(with: profileImageURL, completed: nil)
        
        cell.imageView?.sd_setImage(with: profileImageURL, completed: { (image, error, _, _) in
            
            if error == nil {
                
                //再
                cell.setNeedsLayout()
                
            }
        })
        
        cell.textLabel?.text = self.titleArray[indexPath.row]
        //cell.detailTextLabel?.text = publishedAtArray[indexPath.row]
        
        
        //行数を指定
        //見直し　見やすさを重視する
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        
        cell.textLabel?.numberOfLines = 5
        cell.detailTextLabel?.numberOfLines = 5
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
    }

    //cellの高さ
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return view.frame.size.height/5
    }
    
    
    func getData() {
        
        var text = "https://www.googleapis.com/youtube/v3/search?key=AIzaSyBgz3Lj-n_qhGWXJFLJL6F_KNITXrvKakQ&q=&part=snippet&maxResults=40&order=date"
        
        //URL内の日本語対応
        let url = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        
        //JSON
        //request 値が帰ってきたものを配列に
        AF.request(url as! URLConvertible, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (responce)
            in
            
            //JSON表示確認
            print(responce)
            
            switch responce.result {
                
            case .success:
                
                
                for i in 0...39 {
                    
                    let Json = JSON(responce.data as Any)
                    let videoId = Json["items"][i]["id"]["videoId"].string
                    let publishedAt = Json["items"][i]["snippet"]["publishedAt"].string
                    let title = Json["items"][i]["snippet"]["title"].string
                    
                    let imageURLString = Json["items"][i]["snippet"]["thumbnails"]["default"]["url"].string
                    
                    //YoutubeURL作成
                    //WEBViewで表示
                    let youtubeURL = "https://www.youtube.com/watch?v=\(videoId!)"
                    
                    let channelTitle = Json["items"][i]["snippet"]["channelTitle"].string
                    
                   
                    self.videoIdArray.append(videoId!)
                    //self.publishedAtArray.append(publishedAt!)
                    self.titleArray.append(title!)
                    self.imageURLStringArray.append(url!)
                    self.channelTitleArray.append(channelTitle!)
                    self.youtubeURLArray.append(youtubeURL)
                    
                }
                
                
                break
                
            case .failure(let error):
                print(error)
                
                break
            }
            
            //データを呼ぶ
            self.tableView.reloadData()
            
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //cellがTapされた時に、動画に飛ぶ
        let indexNumber = indexPath.row
        
        let webViewContoroller = WebViewController()
        
        let url = youtubeURLArray[indexNumber]
        
        UserDefaults.standard.set(url, forKey: "url")
        
        present(webViewContoroller, animated: true, completion: nil)
        
        
        
        
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
