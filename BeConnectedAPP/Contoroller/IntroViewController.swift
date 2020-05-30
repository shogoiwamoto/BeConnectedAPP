//
//  IntroViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/19.
//

import UIKit
import Lottie

class IntroViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    /*lottieアニメーションを表示する配列を準備
     ファイル名*/
    var onboardArray = ["1","2","3"]
    
    //アニメーションと一緒に表示するメッセージテキスト
    //var onboardStringArray = ["","",""]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ページがめくれるようにする
        scrollView.isPagingEnabled = true
        
        scrollset()
        
        for i in 0...2 {
            
            //初期化する
            let animaitionView = AnimationView()
            //ファイルを呼び出す
            let animaition = Animation.named(onboardArray[i])
            
            //
            animaitionView.frame = CGRect(x: CGFloat(i) * view.frame.size.width, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            
            animaitionView.animation = animaition
            
            //変更するかも、見やすさ重視！
            animaitionView.contentMode = .scaleAspectFit
            
            animaitionView.loopMode = .loop
            animaitionView.play()
            scrollView.addSubview(animaitionView)
            
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //nanavigationControllerを非表示にする
        navigationController?.isNavigationBarHidden = true
    }
    
    func scrollset() {
        //設定
        scrollView.delegate = self
        
        //scrollの稼働領域
        //widh 4個分の表示
        scrollView.contentSize = CGSize(width: view.frame.size.width * 4, height: view.frame.size.height)
        
        /*
         
         
        
        
        for i in 0...2 {
            
            //CGFroat型にキャスト
            //yは、3分の1で試す　中央に表示する
            let onboardLabel = UILabel(frame: CGRect(x: CGFloat(i) * view.frame.size.width, y: view.frame.size.height/3, width: scrollView.frame.size.width, height: scrollView.frame.size.height))
            
            onboardLabel.font =
                UIFont.boldSystemFont(ofSize: 13.0)
            
            //中央表示
            onboardLabel.textAlignment = .center
            //i番目で代入する
            onboardLabel.text = onboardStringArray[i]
            
            scrollView.addSubview(onboardLabel)
            
        }
        
         */
        
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
