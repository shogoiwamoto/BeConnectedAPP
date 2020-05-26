//
//  LoginViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/23.
//

import UIKit
import Firebase
import Lottie
import Photos


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let animationView = AnimationView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ユーザーに許可を得る　必須
            PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status) {
                
            case.authorized:
                print("許可されています")
                
            case.denied:
                print("拒否された")
            
            case.notDetermined:
                print("notDetermined")
                
            case.restricted:
                print("restricted")
                
            }
            
                
            NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillShow(_:)), name:UIResponder.keyboardWillShowNotification, object: nil)
                //キーボードを閉じる時
            NotificationCenter.default.addObserver(self, selector: #selector(RegisterViewController.keyboardWillHide(_:)), name:UIResponder.keyboardWillHideNotification, object: nil)
                

            // Do any additional setup after loading the view.
        }

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
    
    @objc func keyboardWillShow(_ notification:Notification){
        //iphoneのそれぞれの種類、高さが異なる。それをとってくる。
        let keyboardHeight = ((notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as Any) as AnyObject).cgRectValue.height
        
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        
        
        guard let rect = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else{return}
        
        UIView.animate(withDuration: duration) {
            
            let tranform = CGAffineTransform(translationX: 0, y: 0)
            self.view.transform = tranform
            
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //見直す
        emailTextField.resignFirstResponder()
        
        passwordTextField.resignFirstResponder()
        
    }
    
    //キーボードせり上げる did selectを入れる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return true
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
