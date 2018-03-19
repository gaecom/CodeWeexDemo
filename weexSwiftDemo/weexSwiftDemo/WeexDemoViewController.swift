//
//  WeexDemoViewController.swift
//  weexSwiftDemo
//
//  Created by tianqi on 2018/3/19.
//  Copyright © 2018年 tianqi. All rights reserved.
//

import UIKit
import WeexSDK

class WeexDemoViewController: UIViewController {

    var instance: WXSDKInstance?
    var weexView = UIView()
    var url: URL?
    
    @IBAction func closeView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func refreshButton(_ sender: UIBarButtonItem) {
        render()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
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
        let top = UIApplication.shared.statusBarFrame.height
    
        let weexHeight = self.view.frame.size.height - top;
        
        
        
        instance = WXSDKInstance();
        instance!.viewController = self
//        instance!.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        instance?.frame = CGRect(x: self.view.frame.minX, y: 200, width: self.view.frame.width, height: weexHeight)
        
        weak var weakSelf: WeexDemoViewController? = self
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
//        let urlStr = String.init(format: "file://%@/bundlejs/index.js", Bundle.main.bundlePath)
//        let urlStr = String.init(format: "file://%@/bundlejs/image.js", Bundle.main.bundlePath)
//        url = URL(string: urlStr)
        
//        instance!.render(with: url!, options: ["bundleUrl": urlStr], data: nil)
        
        let url = URL(string: "http://localhost:9090/html/bundlejs/index.js")
        instance?.render(with: url)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
