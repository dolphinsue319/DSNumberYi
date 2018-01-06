//
//  DSNumberYi.swift
//  DSNumberYi
//
//  Created by Dolphin Su on 2018/1/6.
//  Copyright © 2018年 Dolphin Su. All rights reserved.
//

import Foundation

fileprivate let kSymbolsAndValues:[String:[Int]] = [
    "伏位":[11, 22, 33, 44, 55, 66, 77, 88, 99, 10, 20, 30, 40, 50, 60, 70, 80, 90, 15, 25, 35, 45, 65, 75, 85, 95, 51, 52, 53, 54, 56, 57, 58, 59],
    "天醫":[94, 27, 68, 13, 49, 72, 86, 31],
    "生氣":[14, 28, 39, 67, 41, 82, 93, 76],
    "延年":[19, 26, 34, 78, 91, 62, 43, 87],
    "五鬼":[18, 24, 36, 79, 81, 42, 63, 97],
    "六煞":[16, 29, 38, 47, 61, 92, 83, 74],
    "禍害":[17, 23, 46, 89, 71, 32, 64, 98],
    "絕命":[12, 37, 48, 69, 21, 73, 84, 96]
    ]

fileprivate func symbol(_ fromInt: Int) -> String? {
    if fromInt < 10 || fromInt > 99 { return nil }
    for symbol in kSymbolsAndValues.keys {
        for value in kSymbolsAndValues[symbol]! {
            if value == fromInt {
                return symbol
            }
        }
    }
    return nil
}

protocol DSNumberYi {
    func symbols() -> [String]?
}

extension Int: DSNumberYi {
    func symbols() -> [String]? {
        return String(self).symbols()
    }
}

extension String: DSNumberYi {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    func remove5InMiddle() -> String? {
        guard let _ = Int(self) else {
            return nil
        }

        if self.count < 2 {
            return self
        }
        guard let firstChar = self.first else {
            return nil
        }
        guard let lastChar = self.last else {
            return nil
        }
        var newString:String = String(firstChar)
        
        for char in self[1..<self.count-1] {
            if char != "5" {
                newString = newString + String(char)
            }
        }
        return newString + String(lastChar)
    }

    func twoDigitsStringArray() -> [String]? {
        guard let _ = Int(self) else {
            return nil
        }
        if self.count < 2 {
            return nil
        }
        
        var array = [String]()
        for i in 0..<self.count - 1 {
            array.append(self[i...i + 1])
        }
        return array.count == 0 ? nil : array
    }
    
    func symbols() -> [String]? {
        guard let _ = Int(self) else {
            return nil
        }
        
        guard self.remove5InMiddle() != nil else {
            return nil
        }
        
        guard let stringArray = self.remove5InMiddle()!.twoDigitsStringArray() else {
            return nil
        }
        
        var symbols = [String]()
        for twoDigitString in stringArray {
            if let stringInt = Int(twoDigitString) {
                if let symbol = symbol(stringInt) {
                    symbols.append(symbol)
                }
            }
        }
        return symbols.count > 0 ? symbols : nil
    }
    
}
