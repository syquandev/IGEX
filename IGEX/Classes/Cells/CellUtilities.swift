//
//  CellUtilities.swift
//  SimpleExtend
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit
import Core

public class CellsUtilities: NSObject {
    public static let shared = CellsUtilities()
    
    public let normalLabel: UILabel
    public let customFontLabel: UILabel
    public let simpleLabel: UILabel
    public let normalTextField: UITextField
    public let normalTextView: UITextView
    public let chatTextLabel: UILabel
    public let editorLabel: UILabel
    
    public override init() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.numberOfLines = 0
        self.normalLabel = label
        
        let customlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        customlabel.numberOfLines = 0
        self.customFontLabel = customlabel
        
        
        let simpleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        simpleLabel.numberOfLines = 0
        self.simpleLabel = simpleLabel
        
        let textFiled = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.normalTextField = textFiled
        
        let textView = UITextView(frame: CGRect.zero)
        self.normalTextView = textView
        
        self.chatTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        chatTextLabel.numberOfLines = 0
        
        
        let editorLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        editorLabel.numberOfLines = 0
//        editorLabel.normalTextIB = true
        self.editorLabel = editorLabel
    }
    
    public static func getFixRatio(image: UIImage, maxWidth: CGFloat, imageView: UIImageView, contentMode:UIView.ContentMode = UIView.ContentMode.center) -> CGFloat{
        var ratio = image.size.height/image.size.width
        if image.size.width < maxWidth {
            imageView.contentMode = contentMode
            ratio = image.size.height/maxWidth
        }else{
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
        }
        return ratio
    }
    
    
    /*
     Input: Phải có ít nhất là attr hoặc text
     Trong trường hợp chỉ có text thì mặc định sẽ lấy size bình thường bất kể đang thiết kế là gì. Ví dụ file xib font 20 thì hàm này vẫn tình theo trường hợp font size là AppFont.normalFontSize
     MaxWidth: Chiều ngang tối đa
     */
    
    public static func getTextSize(attr: NSAttributedString? = nil, text: String? = nil, type: TextType = TextType.normal , maxWidth: CGFloat) -> CGSize{
        var size = CGSize(width: 0, height: 0)
        let label = CellsUtilities.shared.normalLabel
//        if let content = attr {
//            let layouter = DTCoreTextLayouter(attributedString: content)
//            let maxFrame = CGRect(x: 0, y: 0, width: maxWidth, height:200000000)
//            let textRange = NSRange(location: 0, length: content.length)
//            if let layoutFrame = layouter?.layoutFrame(with: maxFrame, range: textRange){
//                size = layoutFrame.intrinsicContentFrame().size
//            }
//            if type == .normal {
//                size.height = size.height * 1.05
//            }
//        }else if let content = text{
//            label.text = content
//            size = label.sizeWithMaxWidth(maxWidth, lineLimit: 0)
//        } else {
//            return size
//        }
        return size
    }
    
    public static func getTextHeight(attr: NSAttributedString?, limit: Int, maxWidth: CGFloat) -> (CGFloat, Bool){
        let label = CellsUtilities.shared.normalLabel
        label.attributedText = attr
        let heightMax = label.heightWithMaxWidth(maxWidth)
        let heightLimit = label.heightWithMaxWidth(maxWidth, lineLimit: limit)
        let readMore =  heightMax > heightLimit
        return (heightLimit * 1.05, readMore)
    }
    
    public static func getTextHeight(attr: NSAttributedString? = nil, text: String? = nil, type: TextType = TextType.normal , maxWidth: CGFloat) -> CGFloat{
        return getTextSize(attr: attr, text: text, type: type, maxWidth: maxWidth).height
    }
    public static func getTextHeight(attr: NSAttributedString? = nil, maxWidth: CGFloat) -> CGFloat{
        return self.getTextHeight(attr: attr, text: nil, type: TextType.normal, maxWidth: maxWidth)
    }
    public static func getTextHeight(text: String? = nil, maxWidth: CGFloat) -> CGFloat{
        return self.getTextHeight(attr: nil, text: text, type: TextType.normal, maxWidth: maxWidth)
    }
    
    public static func shadowView(_ view: UIView){
        view.addCardShadow()
    }
}
