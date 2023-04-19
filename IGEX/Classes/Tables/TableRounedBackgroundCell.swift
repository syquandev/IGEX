//
//  TableRounedBackgroundCell.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit
import Core

public class TableRounedBackgroundCell: TableCell {
    
    @IBOutlet weak var rounedView: UIView!
    
    override public func bindCellModel(_ cellModel: TableCellModel) {
        super.bindCellModel(cellModel)
        if cellModel.isSelected{
            rounedView.backgroundColor = AppColor.primary.getColor()
        }else{
            rounedView.backgroundColor = AppColor.background.getColor()
        }
    }
}
