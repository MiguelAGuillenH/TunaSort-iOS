//
//  StringExtension.swift
//  MAGH_Modulo5_Practica2
//
//  Created by MAGH on 11/03/24.
//

import Foundation

extension String {
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
    
    func localized(withComment comment : String) -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
