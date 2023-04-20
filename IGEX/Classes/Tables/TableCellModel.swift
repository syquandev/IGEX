//
//  TableCellModel.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit
import IGListKit
import Core
import FontAwesome

public protocol TableCellDelegate: AnyObject{
    func tableCellTouched(_ sender: TableCellModel)
    
}
public protocol TableModelInterface: AnyObject{
    
}


public class TableTextData: NSObject{
    private var _title: String?
    public var title: String?{
        get{
            return _title
        }
        set{
            _title = newValue
            if let val = newValue{
                titleAttr = StringBuilder.shared.clear().append(val).value
            }
        }
    }
    public var titleAttr: NSAttributedString?
    public var titleColor: AppColor = AppColor.normal
    public var icon: TableCellBuildinIcon?
    public var iconSize: CGFloat = TableCellIconSize.s24.rawValue
    public var labelLeftSpace: CGFloat = 8
    public var tag: Int = 0
    public var selected: TableTextData?
    
    public func getTitle(isSelected: Bool = false) -> String?{
        if isSelected, let result = selected?.title{
            return result
        }
        return title
    }
    public func getTitleAttr(isSelected: Bool = false) -> NSAttributedString?{
        if isSelected, let result = selected?.titleAttr{
            return result
        }
        return titleAttr
    }
    
    public func getIcon(isSelected: Bool = false) -> TableCellBuildinIcon?{
        if isSelected, let result = selected?.icon{
            return result
        }
        return icon
    }
    
    public class func create(buildInIcon: TableCellBuildinIcon, text: NSAttributedString, buildInIcon2: TableCellBuildinIcon? = nil) -> [TableTextData]{
        var ret = [TableTextData]()
        let model = TableTextData()
        model.titleAttr = text
        model.icon = buildInIcon
        ret.append(model)
        
        if let icon2 = buildInIcon2{
            let model = TableTextData()
            model.icon = icon2
            ret.append(model)
        }
        
        return ret
    }
    public class func create(key: NSAttributedString, value: NSAttributedString) -> [TableTextData]{
        var ret = [TableTextData]()
        let k = TableTextData()
        k.titleAttr = key
        ret.append(k)
        
        let v = TableTextData()
        v.titleAttr = value
        ret.append(v)
        return ret
    }
}

public class TableCellModel: BaseCellModel{
    public var dataModel: TableModelInterface?
    public var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    public weak var delegate: TableCellDelegate?
    
    public var type: TableCellType = TableCellType.text
    
    public var fixedHeight: CGFloat = 0
    
    private var selected: Bool = false
    
    public var background: AppColor?
    
    public var datas: [TableTextData] = [TableTextData()]
    public var title: String?{
        set{
            getText().title = newValue
        }
        
        get{
            return getText().title
        }
    }
    
    public var titleAttr: NSAttributedString?{
        set{
            getText().titleAttr = newValue
        }
        
        get{
            return getText().titleAttr
        }
    }
    
    public var titleColor: AppColor{
        set{
            getText().titleColor = newValue
        }
        
        get{
            return getText().titleColor
        }
    }
    public var icon: TableCellBuildinIcon?{
        set{
            getText().icon = newValue
        }
        
        get{
            return getText().icon
        }
    }
    
    public var iconSize: CGFloat?{
        set{
            getText().iconSize = newValue ?? 24
        }
        
        get{
            return getText().iconSize
        }
    }
    
    public var isSelected: Bool{
        set{
            selected =  newValue
        }
        
        get{
            return selected
        }
    }
    
    public func addText(_ data: TableTextData){
        if self.datas.first?.title == nil && self.datas.first?.titleAttr == nil{
            self.datas = []
        }
        self.datas.append(data)
    }
    
    public func setSelected(_ data: TableTextData, index: Int = 0){
        self.datas.objectAtIndex(index)?.selected = data
    }
    
    public func setSelectedIcon(_ data: TableCellBuildinIcon, index: Int = 0){
        guard let target = self.datas.objectAtIndex(index) else{
            return
        }
        if target.selected == nil{
            target.selected = TableTextData()
        }
        target.selected?.icon = data
    }
    
    public func getText(_ index: Int = 0) -> TableTextData{
        return datas.objectAtIndex(index) ?? TableTextData()
    }
    
    public convenience init(type: TableCellType, datas: [TableTextData]) {
        if datas.count == 0{
            self.init(text: "Empty")
            return
        }
        self.init(type: type)
        datas.forEach { (item) in
            self.addText(item)
        }
    }
    
    private init(type: TableCellType) {
        super.init()
        self.type = type
    }
    
    //MARK: - Text
    public init(text: String) {
        super.init()
        let model = TableTextData()
        model.titleAttr = StringBuilder().append(text).value
        self.addText(model)
    }
    
    public init(text: NSAttributedString) {
        super.init()
        let model = TableTextData()
        model.titleAttr = text
        self.addText(model)
    }
    
    public convenience init(icon: TableCellBuildinIcon, text: String) {
        let datas = TableTextData.create(buildInIcon: icon, text: StringBuilder().append(text).value)
        self.init(type: .iconText, datas: datas)
    }
    
    public convenience init(topIcon: TableCellBuildinIcon, text: String) {
        let datas = TableTextData.create(buildInIcon: topIcon, text: StringBuilder().append(text).value)
        self.init(type: .iconTopText, datas: datas)
    }
    
    public convenience init(centerIcon: TableCellBuildinIcon, text: String) {
        let datas = TableTextData.create(buildInIcon: centerIcon, text: StringBuilder().append(text).value)
        self.init(type: .iconTextCenter, datas: datas)
    }
    
    public convenience init(text: String, icon: TableCellBuildinIcon, color: AppColor = AppColor.normal) {
        let datas = TableTextData.create(buildInIcon: icon, text: StringBuilder().append(text, color: color).value)
        self.init(type: .textIcon, datas: datas)
    }
    
    public convenience init(text: String, topIcon: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: topIcon, text: StringBuilder().append(text).value)
        self.init(type: .textIconTop, datas: datas)
    }
    
    public convenience init(centerText: String, icon: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: icon, text: StringBuilder().append(centerText).value)
        self.init(type: .textIconCenter, datas: datas)
    }
    
    
    
    public convenience init(icon: TableCellBuildinIcon, text: String, icon2: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: icon, text: StringBuilder().append(text).value, buildInIcon2: icon2)
        self.init(type: .iconTextIcon, datas: datas)
    }
    
    public convenience init(topIcon: TableCellBuildinIcon, text: String, topIcon2: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: topIcon, text: StringBuilder().append(text).value, buildInIcon2: topIcon2)
        self.init(type: .iconTopTextIconTop, datas: datas)
    }
    
    public convenience init(icon: TableCellBuildinIcon, centerText: String, icon2: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: icon, text: StringBuilder().append(centerText).value, buildInIcon2: icon2)
        self.init(type: .iconTextCenterIcon, datas: datas)
    }
    
    
    //MARK: - Icon Buildin - AttributedText
    
    public convenience init(icon: TableCellBuildinIcon, text: NSAttributedString) {
        let datas = TableTextData.create(buildInIcon: icon, text: text)
        self.init(type: .iconText, datas: datas)
    }
    
    public convenience init(topIcon: TableCellBuildinIcon, text: NSAttributedString) {
        let datas = TableTextData.create(buildInIcon: topIcon, text: text)
        self.init(type: .iconTopText, datas: datas)
    }
    
    public convenience init(centerIcon: TableCellBuildinIcon, text: NSAttributedString) {
        let datas = TableTextData.create(buildInIcon: centerIcon, text: text)
        self.init(type: .iconTextCenter, datas: datas)
    }
    
    public convenience init(text: NSAttributedString, icon: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: icon, text: text)
        self.init(type: .textIcon, datas: datas)
    }
    
    public convenience init(text: NSAttributedString, iconButton: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: iconButton, text: text)
        self.init(type: .textIconButton, datas: datas)
    }
    
    public convenience init(text: String, iconButton: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: iconButton, text: StringBuilder().append(text).value)
        self.init(type: .textIconButton, datas: datas)
    }
    
    public convenience init(text: NSAttributedString, topIcon: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: topIcon, text: text)
        self.init(type: .textIconTop, datas: datas)
    }
    
    public convenience init(centerText: NSAttributedString, icon: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: icon, text: centerText)
        self.init(type: .textIconCenter, datas: datas)
    }
    
    
    
    public convenience init(icon: TableCellBuildinIcon, text: NSAttributedString, icon2: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: icon, text: text, buildInIcon2: icon2)
        self.init(type: .iconTextIcon, datas: datas)
    }
    
    public convenience init(topIcon: TableCellBuildinIcon, text: NSAttributedString, topIcon2: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: topIcon, text: text, buildInIcon2: topIcon2)
        self.init(type: .iconTopTextIconTop, datas: datas)
    }
    public convenience init(icon: TableCellBuildinIcon, centerText: NSAttributedString, icon2: TableCellBuildinIcon) {
        let datas = TableTextData.create(buildInIcon: icon, text: centerText, buildInIcon2: icon2)
        self.init(type: .iconTextCenterIcon, datas: datas)
    }
    
    //MARK: - Icon Buildin - AttributedText
    
    public convenience init(rounedText: NSAttributedString, text: NSAttributedString, icon: TableCellBuildinIcon) {
        self.init(text: rounedText, icon: icon)
        type = .textSpaceTextIconRouned
        
        let model = TableTextData()
        model.titleAttr = text
        self.addText(model)
        
    }
    public convenience init(rounedText: String, text: String, icon: TableCellBuildinIcon) {
        self.init(text: rounedText, icon: icon)
        type = .textSpaceTextIconRouned
        
        let model = TableTextData()
        model.title = text
        self.addText(model)
        
    }
    
    //MARK: - Key - Value
    
//    func setKey(_ key: NSAttributedString, value: NSAttributedString){
//        let k = TableTextData()
//        k.titleAttr = key
//        self.addText(k)
//
//        let v = TableTextData()
//        v.titleAttr = value
//        self.addText(v)
//    }
    
    public convenience init(topKey: NSAttributedString, value: NSAttributedString) {
        let datas = TableTextData.create(key: topKey, value: value)
        self.init(type: .keyValueTop, datas: datas)
    }
    
    public convenience init(key: NSAttributedString, value: NSAttributedString) {
            let datas = TableTextData.create(key: key, value: value)
            self.init(type: .keyValue, datas: datas)
        
    }
//
//    func setKey(_ key: String, value: String){
//
//        let builder = StringBuilder()
//        let k = TableTextData()
//        k.titleAttr = builder.appendLight(key).value
//        self.addText(k)
//
//        let v = TableTextData()
//        v.titleAttr = builder.clear().append(value).value
//        self.addText(v)
//    }
    
    public convenience init(key: String, value: String) {
        let builder = StringBuilder()
        let datas = TableTextData.create(key: builder.append(key).value, value: builder.clear().append(value).value)
        self.init(type: .keyValue, datas: datas)
        
    }
    
    public convenience init(topKey: String, value: String) {
        let builder = StringBuilder()
        let datas = TableTextData.create(key: builder.append(topKey).value, value: builder.clear().append(value).value)
        self.init(type: .keyValueTop, datas: datas)
    }
    
    
    
    public override func setSectionController(_ section: Any?) {
        super.setSectionController(section)
        self.delegate = section as? TableCellDelegate
    }
    public override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        if fixedHeight > 0 {
            return fixedHeight
        }
        var extend: CGFloat = 0
        let width = maxWidth - 32
        let iconSize =  self.getText().iconSize
        switch self.type {
        case .keyValue,
             .keyValueTop:
            extend = getHeightKey(width)
            
        case .awesomeLeftRightText:
            extend = getHeightKey(width - 24 - 8)
            
        case .textSpaceTextIconRouned:
            extend = getHeightKey(width - 28 - 32)
            extend += 16
            
        case .text:
            extend = getHeight(width, minus: 0)
            
        case .iconTextIcon,
             .iconTopTextIconTop,
             .iconTextCenterIcon:
            extend = getHeight(width, minus: 72 + iconSize)
            
        default:
            extend = getHeight(width, minus: 8 + iconSize)
            break
        }
        if extend < iconSize{
            extend = iconSize
        }
        return extend + contentInsets.top + contentInsets.bottom
    }
    
    public override func getDataModel() -> Any? {
        return nil
    }
    
    public override func getCellName() -> String {
        return type.rawValue
    }
    
    public override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
    
    
    //MARK: - Height Calculator
    func getHeight(_ maxWidth: CGFloat, minus: CGFloat = 0) -> CGFloat{
        guard let data = datas.first else{
            return 0
        }
        let width = maxWidth - minus
        return getSizeTextData(data, maxWidth: width, isSelected: self.selected).height
    }
    
    func getHeightKey(_ maxWidth: CGFloat) -> CGFloat{
        guard let key = datas.objectAtIndex(0), let value = datas.objectAtIndex(1) else{
            return height
        }
        let keyMaxWidth = maxWidth*0.7
        let keySize = getSizeTextData(key, maxWidth: keyMaxWidth)
        let keyHeight = keySize.height
        let keyWidth = keySize.width
        
        let valueMaxWidth = maxWidth - 8 - keyWidth
        let valueHeight = getSizeTextData(value, maxWidth: valueMaxWidth).height
        
        return max(keyHeight, valueHeight)
    }
    
    func getSizeTextData(_ data: TableTextData?, maxWidth: CGFloat, isSelected: Bool = false) -> CGSize{
        guard let data = data else{
            return CGSize.zero
        }
        return CellsUtilities.getTextSize(attr: data.getTitleAttr(isSelected: isSelected), text: data.getTitle(isSelected: isSelected), type: TextType.normal, maxWidth: maxWidth)
    }
    
    func onTouched(){
        self.delegate?.tableCellTouched(self)
    }
    
    public func toggleSelect(){
        selected = !selected
        self.reloadCell()
    }
}
