//
//  DefaultSectionController.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//

import UIKit
import IGListKit

public class DefaultSectionCellBuilder: BaseCellBuilder{
    public override func parseCellModels() {}
}

public class DefaultSectionController: SectionController<DefaultSectionModel> {
    public override func getCellBuilder() -> CellBuilderInterface? {
        return DefaultSectionCellBuilder()
    }
}

public class DefaultSectionModel: BaseSectionModel {
    
}
