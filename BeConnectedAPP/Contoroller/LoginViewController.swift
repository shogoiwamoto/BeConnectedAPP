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
import TransitionButton


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var loginButton: TransitionButton!
    
    let animationView = AnimationView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        loginButton.backgroundColor = .systemPink
        loginButton.setTitle("ログイン", for: .normal)
        loginButton.cornerRadius = 20
        loginButton.spinnerColor = .white
        loginButton.addTarget(self, action: #selector(loginAction(_:)), for: .touchUpInside)
        
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
    
    
    @IBAction func loginAction(_ sender: Any) {
        
        loginButton.startAnimation() // 2: Then start the animation when the user tap the button
        let qualityOfServiceClass = DispatchQoS.QoSClass.background
        let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
        
    
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
        
            if error != nil {
            
                print(error)
                self.loginButton.stopAnimation(animationStyle: .shake, revertAfterDelay: .leastNonzeroMagnitude, completion: nil)
            
            
            } else {
            
                print("ログイン成功")
            
            backgroundQueue.async(execute: {
                
                sleep(3) // 3: Do your networking task or background work here.
                
                DispatchQueue.main.async(execute: { () -> Void in
                    // 4: Stop the animation, here you have three options for the `animationStyle` property:
                    // .expand: useful when the task has been compeletd successfully and you want to expand the button and transit to another view controller in the completion callback
                    // .shake: when you want to reflect to the user that the task did not complete successfly
                    // .normal
                    self.loginButton.stopAnimation(animationStyle: .expand, completion: {
                        self.performSegue(withIdentifier: "login", sender: nil)
                        
                    })
                    
                    
                    
                })
            })
            
                
                
                
                
                
                
            }
        }
        
        
        
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
