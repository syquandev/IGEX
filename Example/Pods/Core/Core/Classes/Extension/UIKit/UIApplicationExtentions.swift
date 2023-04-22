//
//  UIApplicationExtentions.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 22/04/2023.
//

import UIKit

extension UIApplication {
    public var statusBarView: UIView? {
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            let statusbarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: statusBarHeight))
            statusbarView.alpha = 0
            return statusbarView
        } else {
            return  UIApplication.shared.value(forKey: "statusBar") as? UIView
        }
    }
}

extension NSObject {
    public func delay(delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
    public func delayTask(delay: Double, closure: @escaping () -> ()) -> DispatchWorkItem{
        let task = DispatchWorkItem { closure() }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: task)
        return task
    }
}
