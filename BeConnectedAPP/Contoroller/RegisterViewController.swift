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
import FirebaseStorage

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var likeYouTuberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //画面遷移時のアニメーションを呼び出す
    let animationView = AnimationView()
    
    var contentsArray = [Contents]()
    
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
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            
            if error != nil {
                //エラーの内容を入れる
                print(error as Any)
                
            } else {
                print("ユーザーの作成が成功しました")
                
 
                //DB"child"
                var timeLineDB:DatabaseReference
                timeLineDB = Database.database().reference().child("timeLine").childByAutoId()
                
                
                //uID取得
                timeLineDB.key
                var uIDString = timeLineDB.key
                
                
                //Storage
                //画像のURLの値は、StorageのURL入力
                let storage = Storage.storage().reference(forURL: "gs://fanconnect-15235.appspot.com")
                
                //画像が入るフォルダ
                let key = timeLineDB.child("Users").childByAutoId().key
                
                let imageRef = storage.child("Users").child("\(String(describing: key!)).jpeg")
                
                //画像送信準備
                var userprofileImageData:Data = Data()
                
                //画像→Data型になっている
                if self.userImageView.image != nil {
                    
                    userprofileImageData = (self.userImageView.image?.jpegData(compressionQuality: 0.01))!
                    
                    
                }
                
                
                //Storageに画像を送信
                let uploadTask = imageRef.putData(userprofileImageData, metadata: nil) {
                    (metaData,error) in
                    
                    if error != nil {
                        
                        print(error)
                        return
                    }
                    
                    imageRef.downloadURL { (url, error) in
                        
                        if url != nil {
                            
                            //キーバリュー型でDBに送信
                            let accountinfo = ["userName":self.usernameTextField.text! as Any,"userImage":url?.absoluteString as Any,"likeYoutuber":self.likeYouTuberTextField.text! as Any]
                            
                            print("テスト")
                            
                            //値をDBに送信
                            timeLineDB.updateChildValues(accountinfo)
                            
                        }
                    }
                    
                }
                
    
                //アニメーションストップ
                self.stopAnimation()
                
                //画面遷移
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //見直す
        usernameTextField.resignFirstResponder()
        
        likeYouTuberTextField.resignFirstResponder()
        
        passwordTextField.resignFirstResponder()
        
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
               
            //インスタンス
            let cameraPicker = UIImagePickerController()
            
            cameraPicker.sourceType = sourceType
            cameraPicker.allowsEditing = true
            //設定
            cameraPicker.delegate = self
            present(cameraPicker, animated: true, completion: nil)
                   
                   
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
            
            UserDefaults.standard.set(selectedImage?.jpegData(compressionQuality: 0.1),forKey: "userImage")
            
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
        
        let alertContoroller = UIAlertController(title: "選択", message: "どちらを使用しますか", preferredStyle:.actionSheet)
        
        let actionCamera = UIAlertAction(title: "カメラ", style: .default) { (alert) in
            
            self.doCamera()
            
        }
        
        let actionAlbum = UIAlertAction(title: "アルバム", style: .default) { (alert) in
            
            self.doAlbum()
            
        }
        
        let actionCansel = UIAlertAction(title: "キャンセル", style: .cancel)
        
        
        alertContoroller.addAction(actionCamera)
        alertContoroller.addAction(actionAlbum)
        alertContoroller.addAction(actionCansel)
        
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
