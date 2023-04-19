//
//  TableCell.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit
import Core


public class TableCell: CellModelView<TableCellModel> {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet var labels: [UILabel]!
    
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet var imageHeightConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var labelLeftCst: NSLayoutConstraint?
    private var background: AppColor?
    @IBOutlet var buttons: [UIButton]?

    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let btns = self.buttons{
            if btns.count > 0 {
                return
            }
        }
        addGesture()
    }
    
    func addGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesturehander))
        cellView.addGestureRecognizer(gesture)
    }
    
    @objc
    func tapGesturehander(_ sender: UITapGestureRecognizer){
        getCellModel()?.onTouched()
    }

    override public func bindCellModel(_ cellModel: TableCellModel) {
        super.bindCellModel(cellModel)
        var count = 0
        cellModel.datas.forEach { (data) in
            let selected = cellModel.isSelected
            self.bind(data, label: labels?.objectAtIndex(count), isSelected: selected)
            self.bind(data, imageView: imageViews?.objectAtIndex(count), heightConstraint: imageHeightConstraints?.objectAtIndex(count), isSelected: selected)
            count += 1
        }
        labelLeftCst?.constant = cellModel.getText().labelLeftSpace
        if cellModel.background != self.background{
            background = cellModel.background
            if let bg = background{
                cellView?.backgroundColor = bg.getColor()
            }else{
                cellView?.backgroundColor = AppColor.primary.getColor()
            }
        }
    }
    
    func bind(_ data: TableTextData?, label: UILabel?, isSelected: Bool){
        guard let data = data,
            let label = label else{
                return
        }
        if let val = data.getTitleAttr(isSelected: isSelected){
            label.attributedText = val
        }else{
            label.text = data.getTitle(isSelected: isSelected)
        }
    }
    
    func bind(_ data: TableTextData?, imageView: UIImageView?, heightConstraint: NSLayoutConstraint?, isSelected: Bool){
        guard let data = data,
            let imageView = imageView else{
                return
        }
        if let cst = heightConstraint{
            let iconSize = data.iconSize
            if cst.constant != iconSize{
                cst.constant = iconSize
            }
        }
        imageView.image = data.getIcon(isSelected: isSelected)?.getImage()
    }
    @IBAction func onTouchButton(_ sender: UIButton) {
        getCellModel()?.onTouched()
    }
}

