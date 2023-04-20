//
//  IGSection.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import Core

public class LoadingSectionCellBuilder: BaseCellBuilder{
    public override func parseCellModels() {
        self.addLoading()
    }
}

public class LoadingSection: SectionController<BaseSectionModel> {
    
    public override func getCellBuilder() -> CellBuilderInterface? {
        return LoadingSectionCellBuilder()
    }
}

public class LoadingSectionModel: BaseSectionModel {
    
    public override func customInit() {
        self.id = Random.stringKey()
    }
    
    
    public override func getSectionInit() -> SectionControllerInterface? {
        return LoadingSection()
    }
}
