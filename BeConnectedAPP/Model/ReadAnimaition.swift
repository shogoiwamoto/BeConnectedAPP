//
//  ReadAnimaition.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/23.
//

import Foundation
import UIKit
import Lottie


class readAnimaiton: UIViewController {
    
    
    let animationView = AnimationView()
    
    
    func startAnimaition() {
        
        //lottieのアニメーション名
        let animation = Animation.named("loading")
        
        //サイズ、幅調整する
        //見直しポイント
        animationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/1.5)
        
        animationView.animation = animation
        //ここも見直し、わかりやすい表示をする
        animationView.contentMode = .scaleToFill
        
        animationView.loopMode = .loop
        animationView.play()
        
        view.addSubview(animationView)
    }
    
    
    func stopAnimation() {
        
        //排除する
        animationView.removeFromSuperview()
        
        
    }
    
}
