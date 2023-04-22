//
//  DefaultCell.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 21/04/2023.
//  
//

import UIKit

public class DefaultCell: CellModelView<DefaultCellModel> {

    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func bindCellModel(_ cellModel: DefaultCellModel) {
        super.bindCellModel(cellModel)
    }
}

public protocol DefaultCellDelegate: AnyObject{
    
}

public class DefaultCellModel: BaseCellModel{
    public weak var delegate: DefaultCellDelegate?
    
    public override func setSectionController(_ section: Any?) {
        super.setSectionController(section)
        self.delegate = section as? DefaultCellDelegate
    }
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return 0
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
    
//    public override func getCellName() -> String {
//        return "DefaultCell"
//    }
}
