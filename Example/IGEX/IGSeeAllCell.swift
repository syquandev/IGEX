//
//  IGSeeAllCell.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import IGListKit
import IGEX

public class IGSeeAllCell: CellModelView<IGSeeAllCellModel> {

    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func bindCellModel(_ cellModel: IGSeeAllCellModel) {
        super.bindCellModel(cellModel)
        guard let dataModel = cellModel.dataModel else{
            return
        }
        //TODO
        
        
    }
}


public protocol IGSeeAllCellDelegate: class{
    
}
public protocol IGSeeAllModelInterface: class{
    
}

public class IGSeeAllCellModel: BaseCellModel{
    public var dataModel: IGSeeAllModelInterface?
    public weak var delegate: IGSeeAllCellDelegate?
    
    public override func setSectionController(_ section: Any?) {
        super.setSectionController(section)
        self.delegate = section as? IGSeeAllCellDelegate
    }
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return 44
    }
    
    public override func getDataModel() -> Any? {
        return dataModel
    }
    
//    public override func getCellName() -> String {
//        return "IGSeeAllCell"
//    }
}
