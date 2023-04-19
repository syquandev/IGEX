//
//  IGController.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import IGEX

extension IGController{
    func displaySections(_ sections: [BaseSectionModel], isReplace: Bool = false){
        sectionsDatas = sections
        reloadSections()
    }
}


public class IGController: SimpleIGController{
    let core = IGCore()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func initNavigation(){
        self.title = "IG"
//        self.addDefaultNavBackButton()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        core.setController(self)
        initNavigation()
        viewReady()
        initCollection()
        initCollectionRefresh()
    }
    
    func viewReady(){
        core.viewReady()
    }
    
    public override func getCollectionView() -> UICollectionView? {
        return collectionView
    }
    
    public override func willDisplaySectionIndex(_ sectionIndex: Int) {
        
    }
}

