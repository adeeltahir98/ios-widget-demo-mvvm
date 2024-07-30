//
//  UIColor+Extension.swift
//  Weather
//
//  Created by Adeel Tahir on 17/12/2022.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        var customHex:String!
        customHex = hex + "FF"
        if customHex.hasPrefix("#") {
            let start = customHex.index(customHex.startIndex, offsetBy: 1)
            let hexColor = String(customHex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
