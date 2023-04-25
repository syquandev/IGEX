//
//  ManualLoadingCell.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 24/04/2023.
//  
//

import UIKit
import Core //Halo


//MARK: - SectionModel


public protocol ManualLoadingCellDelegate:class {
    func manualLoadingCellLoad()
}

public class ManualLoadingCell: CellModelView<ManualLoadingCellModel> {
    public weak var delegate: ManualLoadingCellDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func loadMore(_ sender: UIButton) {
        self.delegate?.manualLoadingCellLoad()
    }
}

public class ManualLoadingCellModel: BaseCellModel{
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return 30
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
    
}

