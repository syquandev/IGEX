//
//  UINavigationControllerExtensions.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 22/04/2023.
//
#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UINavigationController {
    
    /// SwifterSwift: Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    func popToViewController(_ viewController: UIViewController?, animated: Bool, _ completion: (() -> Void)?) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        guard let vc = viewController else{
            completion?()
            return
        }
//        CATransaction.begin()
//        CATransaction.setCompletionBlock(completion)
        popToViewController(vc, animated: true)
        self.delay(delay: 1) {
            completion?()
        }
//        CATransaction.commit()
    }
    
    /// SwifterSwift: Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    /// SwifterSwift: Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
    
    
    @objc
    @discardableResult
    func removeControllerClasses(_ classNames: [AnyClass], instance: UIViewController? = nil) -> Bool{
        let controllers =  self.viewControllers.compactMap({ (item) -> UIViewController? in
            for className in classNames{
                if item.isKind(of: className) && item != instance{
                    return nil
                }
            }
            return item
        })
        self.viewControllers = controllers
        return true
    }
        
    @discardableResult
    func removeControllerClass(_ className: AnyClass, instance: UIViewController? = nil) -> Bool{
        return removeControllerClasses([className], instance: instance)
//        let controllers =  self.viewControllers.compactMap({ (item) -> UIViewController? in
//            if item.isKind(of: className) && item != instance{
//                return nil
//            }else{
//                return item
//            }
//        })
//        self.viewControllers = controllers
//        return true
    }
    
    @discardableResult
    func popToControllerClass(_ className: AnyClass, deep: Int = 0) -> Bool{
        
        let rvers = self.viewControllers.reversed()
        for con in rvers{
            if con.isKind(of: className){
                self.popToViewController(con, animated: true)
                return true
            }else{
                if con.isContainChildControllerClass(className, deep: deep){
                    self.popToViewController(con, animated: true)
                    return true
                }
            }
        }
        return false
    }
    
    @discardableResult
    func popToControllerClassName(_ className: String, deep: Int = 0, animated: Bool = true, _ completion: (() -> Void)? = nil) -> Bool{
        let nameLower = className.lowercased()
        let rvers = self.viewControllers.reversed()
        for con in rvers{
            if con.getViewControllerClassName().lowercased() == nameLower{
                self.popToViewController(con, animated: animated)
                if animated{
                    self.delay(delay: 1) {
                        completion?()
                    }
                }
                return true
            }else{
                if con.isContainChildControllerClassName(className, deep: deep){
                    self.popToViewController(con, animated: animated)
                    if animated{
                        self.delay(delay: 1) {
                            completion?()
                        }
                    }
                    return true
                }
            }
        }
        return false
    }
    
}
#endif

public extension UIViewController {
    
    @discardableResult
    func isContainChildControllerClass(_ className: AnyClass, deep: Int = 0) -> Bool{
        
        if deep > 0{
            for child in self.children{
                if child.isKind(of: className){
                    return true
                }else{
                    if child.isContainChildControllerClass(className, deep: deep - 1) {
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    @discardableResult
    func isContainChildControllerClassName(_ className: String, deep: Int = 0) -> Bool{
        
        let nameLower = className.lowercased()
        if deep > 0{
            for child in self.children{
                if child.getViewControllerClassName().lowercased() == nameLower{
                    return true
                }else{
                    if child.isContainChildControllerClassName(className, deep: deep - 1) {
                        return true
                    }
                }
            }
        }
        
        return false
    }
}
