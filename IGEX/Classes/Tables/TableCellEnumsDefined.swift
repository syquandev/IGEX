//
//  TableCellEnumsDefined.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit

public enum TableCellType: String {
    case text               = "TableTextCell"
    
    case keyValue           = "TableKeyValueCell"
    case keyValueTop        = "TableKeyValueTopCell"
    
    case awesomeText        = "TableAwesomeTextCell"
    case awesomeTopText     = "TableAwesomeTopTextCell"
    case awesomeTextCenter  = "TableAwesomeTextCenterCell"
    case awesomeLeftRightText       = "TableAwesomeLeftRightTextCell"
    
    case textAwesome        = "TableTextAwesomeCell"
    case textAwesomeTop     = "TableTextAwesomeTopCell"
    case textAwesomeCenter  = "TableTextAwesomeCenterCell"
    
    case iconText           = "TableIconTextCell"
    case iconTopText        = "TableIconTopTextCell"
    case iconTextCenter     = "TableIconTextCenterCell"
    
    case textIcon           = "TableTextIconCell"
    case textIconTop        = "TableTextIconTopCell"
    case textIconCenter     = "TableTextIconCenterCell"
    
    case textIconButton     = "TableTextIconButtonCell"
    
    case iconTextIcon       = "TableIconTextIconCell"
    case iconTopTextIconTop = "TableIconTopTextIconTopCell"
    case iconTextCenterIcon = "TableIconCenterTextIconCell"
    
    
    case textSpaceTextIconRouned = "TableTextSpaceTextIconRounedCell"
}

public enum TableCellIconSize: CGFloat{
    case s24 = 24
    case s32 = 32
    case s48 = 48
    case s64 = 64
    case s128 = 128
    
    
}

public enum TableCellBuildinIcon {
    case up_dark
    case down_dark
    case left_dark
    case right_dark
    
    case circle_checked
    case circle_ticked
    case circle_uncheck
    
    case plus
    case bar
    case clock
    case custom(String, Bundle?)
    
    public func getImage() -> UIImage?{
        switch self {
        case .custom(let name, let bundle):
            if bundle == nil{
                return UIImage(named: name)
            }
            return UIImage(name:name, bundle: bundle)
        default:
            let name = String(describing: self) + "_buildin_icon"
            return UIImage(name:name, bundle: IGEX.getBundle())
        }
    }
}
