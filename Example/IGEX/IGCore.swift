//
//  IGCore.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import IGEX

public class IGConfiguration{
    public weak var delegate : IGDelegate?
    public init(delegate: IGDelegate? = nil) {
        self.delegate = delegate
    }
}

public protocol IGDelegate: AnyObject {
    
}

extension IGController{
    public static func create(_ config: IGConfiguration? = nil) -> IGController {
        //MARK: - Code Based
        //let presenter: IGPresenter = IGPresenter()

        //MARK: -  Storyboard Base
        let controller: IGController = IGController.createFromStoryboard("IGView", bundle: Bundle.main)
        controller.setConfig(config)
        
        return controller
    }
    
    func setConfig(_ config: IGConfiguration?){
        guard let config = config else{
            return
        }
        core.setConfig(config)
    }
}

public class IGCore: NSObject{
    var config = IGConfiguration()
    var sections: [BaseSectionModel] = []
    
    private weak var controller: IGController?
    public func setController(_ controller: IGController?){
        self.controller = controller
    }
    
    public override init() {
        super.init()
        self.setConfig(config)
    }
    
    
    public func setConfig(_ config: IGConfiguration){
        self.config = config
        sections = [IGSectionModel()]
    }
    
    func viewReady(){
        getData()
    }
    
    func updateSections(_ sections: [BaseSectionModel], after: String?, next: String?){
        let isReplace = after == nil
        if isReplace{
            self.sections = sections
        }else{
            self.sections.append(contentsOf: sections)
        }
        
        controller?.displaySections(self.sections, isReplace: isReplace)
    }
}

