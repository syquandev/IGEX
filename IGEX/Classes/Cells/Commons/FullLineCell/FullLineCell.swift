//
//  FullLineCell.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 24/04/2023.
//  
//

import UIKit
import Core

public class FullLineCell: CellModelView<FullLineCellModel>  {
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}


public class FullLineCellModel: BaseCellModel{
    
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return 1
        
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
}


