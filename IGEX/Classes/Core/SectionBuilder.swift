//
//  SectionBuilder.swift
//  Core_Main
//
//  Created by HU-IOS-DT-QUAN on 05/04/2023.
//

import Foundation
import IGListKit

public protocol SectionBuilderInterface: AnyObject{
    func getSection(object: Any?, presenter: AnyObject?) -> ListSectionController
}

open class SectionBuilder: NSObject, SectionBuilderInterface{
    open func getSection(object: Any?, presenter: AnyObject?) -> ListSectionController{
        if let section = self.getSectionInterface(object: object){
            section.setPresenter(presenter)
            if let sectionModel = object as? BaseSectionModel{
                sectionModel.sectionController = section
            }
            return section.getSectionController()
        }
        
        if let sectionModel = object as? BaseSectionModel{
            if let section = sectionModel.getSectionInit(){
                section.setPresenter(presenter)
                sectionModel.sectionController = section
                return section.getSectionController()
            }
        }
        
        return DefaultSectionController()
    }
    
    open func getSectionInterface(object: Any?) -> SectionControllerInterface?{
        
        if let section = self.getLoadingSection(object){
            return section
        }
        if let section = self.getManualLoadingSection(object){
            return section
        }
        if let section = self.getBlankSection(object){
            return section
        }
        if let section = self.getEmptyDataSection(object){
            return section
        }
        return nil
    }
    
    open func getLoadingSection(_ object: Any?) -> SectionControllerInterface?{
        if object is LoadingSectionModel{
            let section = LoadingSection()
            return section
        }
        return nil
    }
    
    open func getManualLoadingSection(_ object: Any?) -> SectionControllerInterface?{
        if object is ManualLoadingSectionModel{
            let section = ManualLoadingSection()
            return section
        }
        return nil
    }
    
    open func getBlankSection(_ object: Any?) -> SectionControllerInterface?{
        if object is BlankSectionModel{
            let section = BlankSection()
            return section
        }
        return nil
    }
    
    open func getEmptyDataSection(_ object: Any?) -> SectionControllerInterface?{
        if object is EmptyDataSectionModel{
            let section = EmptyDataSection()
            return section
        }
        return nil
    }
}
