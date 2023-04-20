//
//  IGSection.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import IGEX

public protocol IGSectionDelegate: AnyObject{
    
}

public class IGSection: SectionController<IGSectionModel> {
    public weak var delegate: IGSectionDelegate?
    
    // MARK: Properties
    
    public override func setPresenter(_ presenter: AnyObject?) {
        super.setPresenter(presenter)
        self.delegate = presenter as? IGSectionDelegate
        
    }
    
    public override func getCellBuilder() -> CellBuilderInterface? {
        return IGSectionCellBuilder()
    }
}


public class IGSectionModel: BaseSectionModel {
    public var dataModel: Any?
    public var images: [String]?
    
    public override func getSectionInit() -> SectionControllerInterface? {
        return IGSection()
    }
    
    public static func createFrom(_ data: [String]?) -> [IGSectionModel]{
        var sections = [IGSectionModel]()
        if let data = data {
            let s = IGSectionModel()
            s.images = data
            sections.append(s)
        }
        return sections
    }
}

public class IGSectionCellBuilder: BaseCellBuilder{
    public override func parseCellModels() {
        guard let sectionModel = self.sectionModel as? IGSectionModel else{
            return
        }
        
        if let data = sectionModel.images{
            buildImages(data)
        }
    }
    
    func buildImages(_ val: [String]){
        val.forEach { item in
            let cell = IGCellModel()
            cell.dataModel = item
            appendCell(cell)
        }
        
        let more = IGSeeAllCellModel()
        appendCell(more)
    }
}

extension IGCore{
    func getData(){
        let data = ["a", "b", "c"]
        progressData(data)
    }
    
    func progressData(_ data: [String]?){
//        var sections = [IGSectionModel]()
//        data?.forEach({ item in
//            let s = IGSectionModel()
//            s.dataModel = item
//            s.images = data
//            sections.append(s)
//        })
        let sections = IGSectionModel.createFrom(data)
        updateSections(sections, after: nil, next: nil)
    }
}
