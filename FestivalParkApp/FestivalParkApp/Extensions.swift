//
//  Extensions.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 27-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import Foundation

enum CalculationType {
    case height
    case width
}

// MARK: - Calculate percentage of a view - say the main bound
extension UIView {
    func percentage(type: CalculationType, with percentage: CGFloat) -> CGFloat {
        
        if type == .height {
           return percentage * self.frame.height/100
        } else {
           return percentage * self.frame.width/100
        }
    }
}

extension String {
    func containsAnyOf(_ patterns: [String]) -> Bool {
        for pattern in patterns {
            let idx = self.range(of: pattern, options: .caseInsensitive)
            if idx != nil {
                return true
            }
        }
        return false
    }
    
    var html2AttributedString: NSAttributedString? {
        guard
            let data = data(using: String.Encoding.utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:String.Encoding.utf8], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}




extension String {

    func replaceCommaForPoint(of: String, changeWith: String) -> Double {
        return Double(self.replacingOccurrences(of: of, with: changeWith, options: .literal, range: nil))!
    }
}
