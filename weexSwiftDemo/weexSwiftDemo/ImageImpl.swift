//
//  ImageImpl.swift
//  weexSwiftDemo
//
//  Created by tianqi on 2018/3/19.
//  Copyright © 2018年 tianqi. All rights reserved.
//

import Foundation
import WeexSDK
import UIKit
import Kingfisher

class WXImageOperation: NSObject, WXImageOperationProtocol {
    var task: RetrieveImageDownloadTask?
    init(task: RetrieveImageDownloadTask?) {
        self.task = task
    }
    
    func cancel() {
        task?.cancel()
    }
}

class WxImageDownloader: NSObject, WXImgLoaderProtocol {
    func downloadImage(withURL url: String!, imageFrame: CGRect, userInfo options: [AnyHashable : Any]! = [:], completed completedBlock: ((UIImage?, Error?, Bool) -> Void)!) -> WXImageOperationProtocol! {
        
        return WXImageOperation.init(task: ImageDownloader.default.downloadImage(with: URL.init(string: url)!,
                                                                                 completionHandler: { (image, error, url, data) in
            completedBlock?(image, error, data != nil ? true : false)
        }))
    }
}
