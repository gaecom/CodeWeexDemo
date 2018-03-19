//
//  ViewController.swift
//  weexSwiftDemo
//
//  Created by tianqi on 2018/3/18.
//  Copyright © 2018年 tianqi. All rights reserved.
//

import UIKit
import Alamofire
import WeexSDK

class ViewController: UIViewController {

    var instance: WXSDKInstance?
    var weexView = UIView()
    var url: URL?
    
    @IBAction func openWeex(_ sender: Any) {
        
        // Alamofire 4
//        Alamofire.request("https://www.baidu.com").response { response in // method defaults to `.get`
//            debugPrint(response)
//        }
        
//        render()
    }
    
    
    @IBOutlet weak var weexBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        if instance != nil {
            instance!.destroy()
        }
    }
    
    func render() {
        if instance != nil {
            instance!.destroy()
        }
        
        instance = WXSDKInstance();
        instance!.viewController = self
        instance!.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        weak var weakSelf: ViewController? = self
        instance!.onCreate = {
            (view: UIView!)-> Void in
            
            weakSelf!.weexView.removeFromSuperview()
            weakSelf!.weexView = view
            weakSelf!.view.addSubview(self.weexView)
//            UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, weakSelf!.weexView)
        }
        
        instance!.onFailed = {
            (error: Error!)-> Void in
            
            print("faild at error: %@", error)
        } 
        
        instance!.renderFinish = {
            (view:UIView!)-> Void in
            print("render finish")
        }
        
        instance!.updateFinish = {
            (view:UIView!)-> Void in
            print("update finish")
        }
        let urlStr = String.init(format: "file://%@/bundlejs/hello.js", Bundle.main.bundlePath)
        url = URL(string: urlStr)
        
        instance!.render(with: url!, options: ["bundleUrl": urlStr], data: nil)
        
    }
    

}

