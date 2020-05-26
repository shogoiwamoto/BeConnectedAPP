//
//  YouTubeViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/24.
//

import UIKit
import SwiftyJSON
import SDWebImage
import Alamofire
import SegementSlide

class YouTubeViewController: SegementSlideDefaultViewController {
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadData()
        defaultSelectedIndex = 0

        // Do any additional setup after loading the view.
    }
    
    //ヘッダー作成
    override func segementSlideHeaderView() -> UIView {

        let headerView = UIImageView()

        headerView.isUserInteractionEnabled = true
        
        //調整する
        headerView.contentMode = .scaleAspectFill

        headerView.image = UIImage(named: "header")
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false

    let headerHeight: CGFloat

        if #available(iOS 11.0, *) {
            
            headerHeight = view.bounds.height/4+view.safeAreaInsets.top

        } else {

            headerHeight = view.bounds.height/4+topLayoutGuide.length

        }
        
        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true

            return headerView

        }


    //タイトル
    override var titlesInSwitcher: [String] {
        
        return ["ヒカキン","ヒカキン","ヒカキン","本田","長友","マナブ"]
        
        
    }




    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        
        switch index {
            
            case 0:
                return YTPage1ViewController()
            case 1:
                return YTPage2ViewController()
            case 2:
                return YTPage3ViewController()
            case 3:
                return YTPage4ViewController()
            case 4:
                return YTPage5ViewController()
            case 5:
                return YTPage6ViewController()
            
        default:
            return YTPage1ViewController()
            
            
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
