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


extension BaseModel: ListDiffable {
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? BaseModel {
            return self.getDiffID() == object.getDiffID()
        }
        return false
    }
    
    public func mergeDif(){
//        var setResult = Set<BaseModel>()
    }
}
