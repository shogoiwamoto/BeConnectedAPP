//
//  RegisterViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/23.
//

import UIKit
import Firebase
import Lottie
import SDWebImage
import Photos

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var likeYouTuberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //画面遷移時のアニメーションを呼び出す
    let animationView = AnimationView()
    
    var connectArray = [Account]()
    
    //SDWEBimageで使用
    var pictureURLString = String()
    
    //スクリーンサイズをここで取得する
    let screensize = UIScreen.main.bounds.size
    
        
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
    
    
    //Firebaseにユーザー登録
    @IBAction func registerNewUser(_ sender: Any) {
        
        //遷移時のアニメーションスタート
        startAnimaition()
        
        //新規登録
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                //エラーの内容を入れる
                print(error as Any)
                
            } else {
                print("ユーザーの作成が成功しました")
                
                //Auth.auth().signIn(with: Credential) { (result, error) in }
                
                
                
                //DBに送信
                let connectDB = Database.database().reference().child("connect")
                       
                //キーバーリュー型でDBに送信
                let accountinfo = ["userImage":self.userImageView.image!,"userName":self.usernameTextField.text!,"likeYoutuberText":self.likeYouTuberTextField.text!] as [String : Any]
                       
                       //connectDBに入れる
                       connectDB.childByAutoId().setValue(accountinfo) { (error, result) in
                           
                           if error != nil {
                               
                               print(error)
                               
                           } else {
                               
                               print("送信完了")
                               
                               
                               
                           }
                       }
                
                //アニメーションストップ
                self.stopAnimation()
                
                //画面遷移
                self.performSegue(withIdentifier: "", sender: nil)
                
            }
            
        }
        
        
        
        
    }
    
    /*
     var displayname = string()
     var URL = string()
     var URLstring = string()
     
     */
    
    
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //見直す
        usernameTextField.resignFirstResponder()
        
        likeYouTuberTextField.resignFirstResponder()
        
    }
    
    //キーボードせり上げる did selectを入れる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func imageViewTap(_ sender: Any) {
        
        let generator = UINotificationFeedbackGenerator()
        
        generator.notificationOccurred(.success)
        
        //アラートを出す
        showAlart()
        
        
    }
    
    
    //カメラ立ち上げ
    func doCamera() {
        
        let sourceType:UIImagePickerController.SourceType = .camera
        
        //カメラ利用可能か確認
        if  UIImagePickerController.isSourceTypeAvailable(.camera) {
               
            //インスタンスを作成する
            let cameraPicker = UIImagePickerController()
            
            cameraPicker.sourceType = sourceType
            cameraPicker.allowsEditing = true
            //設定
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
                   
                   
            }else {
                   
                print("エラー")
            }
        
    }
    
    //アルバム立ち上げ
    func doAlbum() {
        
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        
        //アルバム利用可能か確認
        if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
           
        //インスタンスを作成する
        let cameraPicker = UIImagePickerController()
        
        cameraPicker.sourceType = sourceType
        cameraPicker.allowsEditing = true
        //設定
        cameraPicker.delegate = self
        self.present(cameraPicker, animated: true, completion: nil)
               
               
        }else {
               
            print("エラー")
        }
        
        
    }
    
    //上のカメラ、アルバムのデータがここに入る
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if info[.originalImage] as? UIImage != nil {
            
            let selectedImage = info[.originalImage] as! UIImage?
            
            UserDefaults.standard.set(selectedImage?.jpegData(compressionQuality: 0.1),forKey: "userimage")
            
            userImageView.image = selectedImage
            //picerを閉じる
            picker.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
    //キャンセル時
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //picerを閉じる
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //アラート
    func showAlart() {
        
        let alertContoroller = UIAlertController(title: "選択", message: "どちらを使用しますか", preferredStyle: .actionSheet)
        
        let actionCamera = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            
            self.doCamera()
            
        }
        
        let actionAlbum = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            
            self.doAlbum()
            
        }
        
        let actionCansel = UIAlertAction(title: "キャンセル", style: .cancel)
        
        
        alertContoroller.addAction(actionCamera)
        alertContoroller.addAction(actionAlbum)
        
        self.present(alertContoroller, animated: true, completion: nil)
        
        
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