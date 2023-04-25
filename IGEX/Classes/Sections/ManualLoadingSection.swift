//
//  ManualLoadingSection.swift
//  Pods
//  
//

import UIKit

public protocol ManualLoadingSectionDelegate: AnyObject{
    
}

public class ManualLoadingSection: SectionController<ManualLoadingSectionModel> {
    public weak var delegate: ManualLoadingSectionDelegate?
    
    // MARK: Properties
    
    public override func setPresenter(_ presenter: AnyObject?) {
        super.setPresenter(presenter)
        self.delegate = presenter as? ManualLoadingSectionDelegate
        
    }
    
    public override func getCellBuilder() -> CellBuilderInterface? {
        return ManualLoadingSectionCellBuilder()
    }
}


public class ManualLoadingSectionModel: BaseSectionModel {
    public var dataModel: Any?
    
    public override func getSectionInit() -> SectionControllerInterface? {
        return ManualLoadingSection()
    }
}


public class ManualLoadingSectionCellBuilder: BaseCellBuilder{
    public override func parseCellModels() {
        guard let sectionModel = self.sectionModel as? ManualLoadingSectionModel else{
            return
        }
        
    }
}
