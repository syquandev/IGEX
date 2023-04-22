//
//  SystemViewController.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 22/04/2023.
//

import UIKit

public enum NavigationStyle {
    case clear
    case dark
    case light
    case image
    
    public func getBarStyle() -> UIStatusBarStyle{
        switch self {
        case .light:
            return .lightContent
        default:
            return .default
        }
    }
}

public protocol ModuleViewControllerBaseInterface: class{
    func getViewController() -> UIViewController
}

public extension UIViewController{
    func getViewControllerClassName() -> String{
        return String(describing: type(of: self))
    }
}

open class SystemViewController: UIViewController, UIGestureRecognizerDelegate {

    public var addKeyboardListenerEvent = false;
    public var viewDidAppearCount = -1;
    
    public var prevHidesBarsOnSwipe = false
    public var hidesBarsOnSwipe = false
    
    public var prevHidesNavigationbar = false
    public var hidesNavigationbar = false
    
    public var prevHidesToolbar = false
    public var hidesToolbar = true
    var isViewWillReappear = false
    var isViewDidReappear = false
    public var isAppearOnScreen = false
    
    public var disableStatusChanged = false
    
    public var isChildController = false
    public var needClearDupcliate = false
    
    public var statusbarColor: AppColor = AppColor.primary
    public var navigationStyle: NavigationStyle = .dark
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func _setupDebug(){
//        if Device.shared.devServer != nil && Config.debugMode{
//            let frame = UIScreen.main.bounds
//            var count = 0
//            var par = self.parent
//            while par != nil{
//                par = par?.parent
//                count += 1
//            }
//
//            let button = UIButton(frame: frame)
//            button.alpha = 0.5
//            button.isUserInteractionEnabled = true
//            button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
//            button.setTitle(getViewControllerClassName(), for: [])
//            button.backgroundColor = UIColor.black
//            button.setTitleColor(UIColor.white, for: [])
//            view.addSubview(button)
//            button.pinTopToView(view, constant: CGFloat(20*count + 20))
//            button.pinLeadingToView(view, constant: 16)
//            button.pinTrailingToView(view, constant: 16)
//            button.pinHeightFixedTo(constant: 16)
//            button.addTarget(self, action: #selector(_copyViewName), for: .touchUpInside)
//        }
    }
    
    @objc func _copyViewName(sender: UIButton!) {
        let name = getViewControllerClassName()
        UIPasteboard.general.string = name
        HUD.showAlert("View name Copied")
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle{
        return navigationStyle.getBarStyle()
    }
    
    open func initUIVariable(){
        
    }
    
    open func initPrevNavigationVariable(){
        self.prevHidesBarsOnSwipe = self.navigationController?.hidesBarsOnSwipe ?? false
        
        self.prevHidesNavigationbar = self.navigationController?.isNavigationBarHidden ?? false
        
        self.prevHidesToolbar = self.navigationController?.isToolbarHidden ?? false
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    open func setCurrentNavigationVariable(){
        if isChildController{
            return
        }
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.hidesBarsOnSwipe = self.hidesBarsOnSwipe
        self.navigationController?.setNavigationBarHidden(self.hidesNavigationbar, animated: true)
        self.navigationController?.setToolbarHidden(self.hidesToolbar, animated: true)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.isAppearOnScreen = true
        self.checkWillReappear()
        self.setCurrentNavigationVariable()
        self.setNavBarColor()
        // Keyboard listenner
        if self.addKeyboardListenerEvent {
            self.addKeyboardListener()
        }
        
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.isAppearOnScreen = false
        if self.addKeyboardListenerEvent {
            self.removeKeyboardListener()
        }
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppearCount += 1
        self.isAppearOnScreen = true
        self.checkDidReappear()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isAppearOnScreen = false
    }
    
    open func viewDidReappear(){
        
    }
    
    open func viewWillReappear(){
        
    }
    
    open func viewDidFirstAppear(){
        
    }
    
    open func setNavBarColor(){
        
    }
    
    open func clearDupcliate(){
        if self.needClearDupcliate{
            self.navigationController?.removeControllerClass(self.classForCoder, instance: self)
        }
    }
    
    func checkWillReappear(){
        if self.isViewWillReappear {
            viewWillReappear()
        }
        self.isViewWillReappear = true
    }
    
    func checkDidReappear(){
        if self.isViewDidReappear {
            viewDidReappear()
        }else{
            viewDidFirstAppear()
        }
        self.isViewDidReappear = true
    }
    
    func addKeyboardListener(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardListener(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        self.keyboardShowHeight(keyboardFrame.size.height)
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        self.keyboardHide()
    }
    
    public var keyboardShowHeightValue: CGFloat = 0
    open func keyboardShowHeight(_ height:CGFloat){
        if let constraints = self.getPreventKeyboadHeightConstraint(){
            var extendBottom: CGFloat = 0
            if #available(iOS 11.0, *) {
                extendBottom = view.safeAreaInsets.bottom
            }
            let cvalue = getPreventKeyboadHeightConstraintExtend() + height - extendBottom
            constraints.forEach { item in
                item.constant = cvalue
            }
            keyboardShowHeightValue = height
//            constraint.constant = getPreventKeyboadHeightConstraintExtend() + height - extendBottom
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
    open func keyboardHide(){
        keyboardShowHeightValue = 0
        if let constraints = self.getPreventKeyboadHeightConstraint(){
//            constraint.constant = 0
            constraints.forEach { item in
                item.constant = 0
            }
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
        
    }
    open func getPreventKeyboadHeightConstraint() -> [NSLayoutConstraint]?{
        return nil
    }
    open func getPreventKeyboadHeightConstraintExtend() -> CGFloat{
        return 0
    }
    
    
    open func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    open func clearNavigationBackground(_ clear: Bool, animated: Bool){
        if animated{
            UIView.animate(withDuration: 0.2) {
                self.clearNavigationBackground(clear)
            }
        }else{
            self.clearNavigationBackground(clear)
        }
    }
    
    
    open func clearNavigationBackground(_ clear: Bool){
        let bar = self.navigationController?.navigationBar
        if clear{
            bar?.setBackgroundImage(UIImage(), for: .default)
            bar?.shadowImage = UIImage()
            bar?.isTranslucent = true
            bar?.backgroundColor = UIColor.clear
            
        }else{
            
            bar?.setBackgroundImage(nil, for: .default)
            bar?.shadowImage = nil
            bar?.isTranslucent = false
            bar?.backgroundColor = AppColor.primary.getColor()
        }
        UIApplication.shared.statusBarView?.backgroundColor = bar?.backgroundColor
    }
    
}
