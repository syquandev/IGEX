//
//  IGCell.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import IGListKit
import IGEX

public class IGCell: CellModelView<IGCellModel> {

    @IBOutlet weak var titleLabel: UILabel!
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func bindCellModel(_ cellModel: IGCellModel) {
        super.bindCellModel(cellModel)
        guard let dataModel = cellModel.dataModel else{
            return
        }
        
        titleLabel.text = dataModel
        
    }
}


public protocol IGCellDelegate: AnyObject{
    
}
public protocol IGModelInterface: AnyObject{
    
}

public class IGCellModel: BaseCellModel{
    public var dataModel: String?
    public weak var delegate: IGCellDelegate?
    
    public override func setSectionController(_ section: Any?) {
        super.setSectionController(section)
        self.delegate = section as? IGCellDelegate
    }
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return 44
    }
    
    public override func getDataModel() -> Any? {
        return dataModel
    }
    
    public override func getBundle() -> Bundle? {
        return Bundle.main
    }
    
    public override func getCellName() -> String {
        return "IGCell"
    }
}
