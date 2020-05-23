//
//  LoginViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/23.
//

import UIKit
import Firebase
import Lottie


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let animationView = AnimationView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func login(_ sender: Any) {
        
        startAnimaition()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                
                print(error)
                
                
            } else {
                
                print("ログイン成功")
                
                self.stopAnimation()
                
                self.performSegue(withIdentifier: "next", sender: nil)
            }
            
            
        }
        
        
    }
    
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
