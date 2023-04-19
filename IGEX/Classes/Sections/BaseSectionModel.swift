//
//  BaseSectionModel.swift
//  SimpleExtend
//
//  Created by Quan on 29/11/2022.
//
import Foundation
import UIKit
import Core
import IGListKit

open class BaseSectionModel: BaseModel {
    public weak var sectionController: SectionControllerInterface?
    open func getSectionInit() -> SectionControllerInterface?{
        return nil
    }
    
    deinit {
//        print("\(String(describing: self)) section model deinit")
    }

}

extension BaseModel : ListDiffable{
    public func diffIdentifier() -> NSObjectProtocol {
            return getDiffID() as NSObjectProtocol
        }
        
        public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
            if let obj = object as? BaseModel {
                return self.id  == obj.id
            }
            return false
        }
}
