//
//  TextCellModel.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import Core

public enum TextType: String {
    case normal = "TextCell"
    case normalDT = "TextDTCell"
    case touchable = "TextTouchableCell"
    case limited = "TextLimitedCell"
}


public protocol TextCellDelegate: class{
    
}


public class TextData: NSObject{
    
    public var text: NSAttributedString?
    public var string: String?
    public var color = AppColor.normal
    public var tag: Int = 0
}

open class TextCellModel: BaseCellModel{
    public weak var delegate: TextCellDelegate?
    public var contentInsets: UIEdgeInsets = UIEdgeInsetsMake(4, 16, 4, 16)
    var type: TextType = TextType.normal
    var lineLimit = 0
    public var text: NSAttributedString?{
        set{
            getText().text = newValue
        }
        
        get{
            return getText().text
        }
    }
    public var string: String?{
        set{
            getText().string = newValue
        }
        
        get{
            return getText().string
        }
    }
    
    public var textColor = AppColor.normal
    public var backgroundColor = AppColor.background
    
    public var fixedHeight: CGFloat = -1
    
    
    public var texts: [TextData] = [TextData()]
    
    public override init() {
        super.init()
    }
    
    
    public convenience init(text: String, color: AppColor = AppColor.normal) {
        self.init()
        self.type = TextType.normal
        self.string = text
    }
    
    public convenience init(text: NSAttributedString) {
        self.init()
        self.type = TextType.normal
        self.text = text
    }
    
    public convenience init(textDT: NSAttributedString) {
        self.init()
        self.type = TextType.normalDT
        self.text = textDT
    }
    
    public convenience init(text: String, font: AppFont) {
        self.init(text: text, color: AppColor.normal, font: font)
    }
    
    public convenience init(text: String, font: AppFont, color: AppColor) {
        self.init(text: text, color: color, font: font)
    }
    
    public convenience init(text: String, color: AppColor, font: AppFont) {
        self.init()
        self.type = TextType.normal
        let builder = StringBuilder()
        builder.append(text, color: color, font: font)
        self.text = builder.value
    }
    
    public convenience init(touch: NSAttributedString, limit: Int = 0) {
        self.init()
        self.type = .touchable
        if limit > 0 {
            self.type = .limited
        }
        lineLimit = limit
        self.text = touch
    }
    
    public convenience init(text: NSAttributedString, limit: Int) {
        self.init(touch: text, limit: limit)
    }
    
    public convenience init(text: String, limit: Int) {
        self.init(touch: StringBuilder().append(text).value, limit: limit)
    }
    
    
    public func addText(_ data: TextData){
        self.texts.append(data)
    }
    
    public func getText(_ index: Int = 0) -> TextData{
        return texts.objectAtIndex(index) ?? TextData()
    }
    
    
    
    public override func setSectionController(_ section: Any?) {
        super.setSectionController(section)
        self.delegate = section as? TextCellDelegate
    }
    
    open override func getCellHeight(maxWidth: CGFloat) -> CGFloat {
        if fixedHeight > 0 {
            return fixedHeight
        }
        
        let width = maxWidth - 32 // default left + right
        
        var height: CGFloat = -1
        
        var textHeight: CGFloat = 0
        
        if type == .limited{
            textHeight = CellsUtilities.getTextHeight(attr: text, limit: lineLimit, maxWidth: width).0
        }else{
            textHeight = CellsUtilities.getTextHeight(attr: text, text: string, type: type, maxWidth: width)
            
        }
        height += textHeight
        height += contentInsets.top
        height += contentInsets.bottom
        return height
    }
    
    
    open override func getDataModel() -> Any? {
        return nil
    }
    
    open override func getCellName() -> String {
        return type.rawValue
    }
    
    open override func getBundle() -> Bundle? {
        return IGEX.getBundle()
    }
    
}
