//
//  SingleLineCell.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 24/04/2023.
//  
//

import UIKit
import Core

public class SingleLineCell: CellModelView<SingleLineCellModel>  {
    @IBOutlet weak var leadingCst: NSLayoutConstraint!
    @IBOutlet weak var trailingCst: NSLayoutConstraint!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func bindCellModel(_ cellModel: SingleLineCellModel) {
        super.bindCellModel(cellModel)
        leadingCst.constant = cellModel.leading
        trailingCst.constant = cellModel.trailing
    }
}


public class SingleLineCellModel: BaseCellModel{
    public var leading: CGFloat = 16
    public var trailing: CGFloat = 16
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return 1
        
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
}


