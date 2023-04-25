//
//  BlockShadowCell.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 24/04/2023.
//  
//

import UIKit
import Core

class BlockShadowCell: CellModelView<BlockShadowCellModel> {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}

public class BlockShadowCellModel: BaseCellModel{
    
    public override init() {
        super.init()
        self.height = 8
    }
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return height
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
    
}

public class BlockShadowSectionCellBuilder: BaseCellBuilder{
    public override func parseCellModels() {
        self.addBlockShadow()
    }
}

public class BlockShadowSection: SectionController<BlockShadowSectionModel> {
    public override func getCellBuilder() -> CellBuilderInterface? {
        return BlockShadowSectionCellBuilder()
    }
}


public class BlockShadowSectionModel: BaseSectionModel {
    
    
    public override func getSectionInit() -> SectionControllerInterface? {
        return BlockShadowSection()
    }
}
