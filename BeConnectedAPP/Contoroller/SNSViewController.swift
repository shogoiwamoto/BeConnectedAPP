//
//  SNSViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/28.
//

import UIKit
import SegementSlide
import SDWebImage
import Firebase

class SNSViewController: SegementSlideDefaultViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            reloadData()
            defaultSelectedIndex = 0
        }
        
        //ヘッダー作成
    override func segementSlideHeaderView() -> UIView {

        let headerView = UIImageView()

        headerView.isUserInteractionEnabled = true
               
        //調整する
        headerView.contentMode = .scaleAspectFill

        headerView.image = UIImage(named: "SNSheader")
               
               
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
            return SNSPage1ViewContoroller()
        case 1:
            return SNSPage2ViewController()
        case 2:
            return SNSPage3ViewContoroller()
        case 3:
            return SNSPage4ViewContoroller()
        case 4:
            return SNSPage5ViewContoroller()
        case 5:
            return SNSPage6ViewContoroller()
                
        default:
            return SNSPage1ViewContoroller()
                
                
        }
            
            
    }
        
        


}
