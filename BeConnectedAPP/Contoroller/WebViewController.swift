//
//  WebViewController.swift
//  BeConnectedAPP
//
//  Created by 岩本省吾 on 2020/05/24.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    
    var webview = WKWebView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - 50)
        
        view.addSubview(webview)
        
        if UserDefaults.standard.object(forKey: "url") != nil {
            
            let urlString = UserDefaults.standard.object(forKey: "url")
            
            let url = URL(string: urlString as! String)
            
            let request = URLRequest(url: url!)
            
            webview.load(request)
            
            
            
        }

        // Do any additional setup after loading the view.
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
