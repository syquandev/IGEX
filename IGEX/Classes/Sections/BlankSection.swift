//
//  BlankSection.swift
//  IGEX
//
//  Created by HU-IOS-DT-QUAN on 24/04/2023.
//

import Foundation
import UIKit
import Core
import ObjectMapper

public class BlankSectionCellBuilder: BaseCellBuilder{
    public override func parseCellModels() {
        guard let sectionModel = self.sectionModel as? BlankSectionModel else {
            return
        }
        self.addBlankSpace(sectionModel.height, color: sectionModel.color)
    }
}

public class BlankSection: SectionController<BlankSectionModel> {
    public override func getCellBuilder() -> CellBuilderInterface? {
        return BlankSectionCellBuilder()
    }
}


public class BlankSectionModel: BaseSectionModel {
    public var height: CGFloat = 8
    public var color: UIColor = UIColor.white
    
    public override init() {
        super.init()
        self.height = 8
    }
    public init(height: CGFloat) {
        super.init()
        self.height = height
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func getSectionInit() -> SectionControllerInterface? {
        return BlankSection()
    }
}
