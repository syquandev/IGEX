//  BaseCellBuilder.swift
//  IGEX
//
//  Created by Quan on 29/11/2022.

import UIKit

public class IGEX: NSObject {
    
    public static let shared = IGEX()

    public static func getBundle() -> Bundle? {
        let frameworkBundle = Bundle(for: IGEX.self)
        let path = frameworkBundle.resourceURL?.appendingPathComponent("IGEXBundle.bundle")
        let resourcesBundle = Bundle(url: path!)
        return resourcesBundle
        
    }
    
    public static func resourcesPath(name: String, type: String) -> String? {
        let bundle = IGEX.getBundle()
        let pathForResourceString = bundle?.path(forResource: name, ofType: type)
        return pathForResourceString
    }
    
}
