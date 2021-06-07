//
//  DateFormatter.swift
//  ProjectLightning
//
//  Created by oles on 17.10.2020.
//

import UIKit

extension DateFormatter {
    
    static let appDefaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .full
        return formatter
    }()

    static let appShortFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.timeZone = .none
        return formatter
    }()

    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}

extension Date {
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func convertDateToString(timeZone : String) -> (String?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        if timeZone == "" {
            dateFormatter.timeZone = TimeZone.current
        }
        else {
            dateFormatter.timeZone = TimeZone(abbreviation: timeZone) //"UTC"
        }
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
