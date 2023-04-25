//
//  BlankSpaceCell.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 24/04/2023.
//  
//

import UIKit

class DefaultCell: CellModelView<DefaultCellModel> {
    
}

public class DefaultCellModel: BaseCellModel{
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return 0
        
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
}

class BlankSpaceCell: CellModelView<BlankSpaceCellModel> {

    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func bindCellModel(_ cellModel: BlankSpaceCellModel) {
        super.bindCellModel(cellModel)
        self.backgroundColor = cellModel.color
        self.backView.backgroundColor = cellModel.color
    }

}

public class BlankSpaceCellModel: BaseCellModel{
    
    public var color: UIColor = UIColor.white
    
    public init(height: CGFloat) {
        super.init()
        self.height = height
    }
    
    
    public override init() {
        super.init()
        self.height = 0
    }
    
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return self.height
        
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
}
