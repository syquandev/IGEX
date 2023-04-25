//
//  EmptyDataCell.swift
//  Pods
//
//  Created by HU-IOS-DT-QUAN on 24/04/2023.
//  
//

import UIKit
import Core
import ObjectMapper

public class EmptyDataCell: CellModelView<EmptyDataCellModel> {
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var loadingButton: UIButton!
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func bindCellModel(_ cellModel: EmptyDataCellModel) {
        super.bindCellModel(cellModel)
        self.holderView.backgroundColor = cellModel.background
        self.contentButton.setTitle(cellModel.content, for: .normal)
        guard let dataModel = cellModel.dataModel else{
            return
        }
        imageView?.image = dataModel.getImage()
        loadingButton.isHidden = !cellModel.enableReloadButton
        //TODO
        
    }
    
    @IBAction func onNeedReload(_ sender: UIButton) {
        getCellModel()?.needReload()
    }
    
    public override func willDisplay() {
        super.willDisplay()
        if self.getCellModel()?.autoHeight ?? false{
            if let superHeight = self.superview?.frame.height,
                let fixed = self.getCellModel()?.fixedHeight{
                if fixed < 0 {
                    self.getCellModel()?.fixedHeight = superHeight - self.frame.origin.y
                    self.getCellModel()?.invalidateCell()
                }
            }
        }
    }
}


public protocol EmptyDataCellDelegate: AnyObject{
    func needReloadData(_ sender: EmptyDataCellModel)
}

public class EmptyDataCellModel: BaseCellModel{
    public var dataModel: SectionError?
    public weak var delegate: EmptyDataCellDelegate?
    public var content: String = ""
    public var background: UIColor = UIColor.clear
    public var fixedHeight: CGFloat = -1
    public var autoHeight: Bool = false
    public var enableReloadButton: Bool = false
    
    public override func setSectionController(_ section: Any?) {
        super.setSectionController(section)
        self.delegate = section as? EmptyDataCellDelegate
    }
    
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        if fixedHeight > 0 {
            return fixedHeight
        }
        return 280
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
    
    func needReload(){
        delegate?.needReloadData(self)
    }
}


public class EmptyDataSectionCellBuilder: BaseCellBuilder{
    public override func parseCellModels() {
        let cellModel = EmptyDataCellModel()
        if let sectionModel = self.sectionModel as? EmptyDataSectionModel{
            cellModel.autoHeight = sectionModel.autoHeight
            cellModel.dataModel = sectionModel.type
            cellModel.enableReloadButton = sectionModel.enableReloadButton
        }
        self.cellModels.safeAppend(cellModel)
        self.addBlankSpace(50)
    }
}

public protocol EmptyDataSectionDelegate: AnyObject{
    func needReloadData(_ sender: EmptyDataSectionModel?)
}

public class EmptyDataSection: SectionController<EmptyDataSectionModel> {
    public weak var delegate: EmptyDataSectionDelegate?
    
    public override func setPresenter(_ presenter: AnyObject?) {
        super.setPresenter(presenter)
        self.delegate = presenter as? EmptyDataSectionDelegate
    }
    
    
    public override func getCellBuilder() -> CellBuilderInterface? {
        return EmptyDataSectionCellBuilder()
    }
}


extension EmptyDataSection: EmptyDataCellDelegate{
    public func needReloadData(_ sender: EmptyDataCellModel) {
        self.delegate?.needReloadData(self.sectionModel)
    }
}


public class EmptyDataSectionModel: BaseSectionModel {
    public var type: SectionError = SectionError.empty
    public var autoHeight: Bool = false
    public var enableReloadButton: Bool = false
    public override init() {
        super.init()
        self.id = Random.stringKey()
    }
    
    public required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func getSectionInit() -> SectionControllerInterface? {
        return EmptyDataSection()
    }
}
