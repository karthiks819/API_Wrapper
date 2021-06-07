//
//  String.swift
//  ProjectLightning
//
//  Created by oles on 16.10.2020.
//

import UIKit

postfix operator ~

extension String {
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    static postfix func ~ (string: String) -> String {
        return NSLocalizedString(string, comment: "")
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")-> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.init(abbreviation: "GMT")
        dateFormatter.locale = Locale.init(identifier:"en_US_POSIX")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
}
