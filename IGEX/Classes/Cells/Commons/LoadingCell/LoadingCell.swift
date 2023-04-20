//
//  LoadingCell.swift
//
//  Created by An Nguyen on 20/04/23.
//

import UIKit
import Shimmer
import Core

class LoadingCell: UICollectionViewCell {
    @IBOutlet weak var shimmeringView: FBShimmeringView!
    @IBOutlet var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let contentView = self.containerView
//        contentView?.removeFromSuperview()
        self.shimmeringView.contentView = containerView
        contentView?.frame = self.shimmeringView.bounds
        contentView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.shimmeringView.isShimmering = true
    }

}

public class LoadingCellModel: BaseCellModel{
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        return 150
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
    
}




