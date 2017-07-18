//
//  Utils.swift
//  LAFDBrush
//
//  Created by Kahuna on 6/12/17.
//  Copyright © 2017 Kahuna Systems Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit

struct Utils {

    static func getCurrentDate() -> Date {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateFormatter.date(from: dateString)!
    }

    static func getCurrentDateWithTimeZone(isTimeZone: Bool) -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var dateString = dateFormatter.string(from: date)
        if isTimeZone {
            dateString = dateString.replacingOccurrences(of: " ", with: "T")
        }
        return dateString
    }

    static func convertFromString(dateStr: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        return dateFormatter.date(from: dateStr)!
    }

    static func convertFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }

    static func updateTimeLabel() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }

    static func updateTimeLabel(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY HH:mm"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    static func updateDateLabel(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    static func updateDateWithYearLabel(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    static func convertDateWithDateFormatStr(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    static func getDateWithTimeZone(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

    static func getDateTimeWithoutTimeZone(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM_dd_yyyy HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }

}
