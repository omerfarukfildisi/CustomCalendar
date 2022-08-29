//
//  CalendarHelper.swift
//  Calendar
//
//  Created by Ömer Fildişi on 23.08.2022.
//

import Foundation
import UIKit

class CalendarHelper{
    
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    let todayDate = Date()
    var selectedDate = String()
    static let shared = CalendarHelper()
    
    init() {
        dateFormatter.locale = Locale(identifier: "en")
    }
    
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func dayString(date: Date) -> String {
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    func monthString(date: Date) -> String {
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: date)
    }
    
    func yearString(date: Date) -> String {
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func dayMonthYearString(date: Date) -> String {
        dateFormatter.dateFormat = "dd-LLLL-yyyy"
        return dateFormatter.string(from: date)
    }
    
    func setDateString(date: Date) -> String {
        return "\(dayString(date: date))\("-")\(monthString(date: date))\("-")\(yearString(date: date))"
    }
    
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int {
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 2
    }
    
    func setCalendarDays(date: Date) -> [CalenderDay] {
        var calenderDays = [CalenderDay]()
        let daysInMonth = daysInMonth(date: date)
        let lastDayOfPreviousMonth = CalendarHelper().firstOfMonth(date: date)
        var startingSpaces = CalendarHelper().weekDay(date: lastDayOfPreviousMonth)
        if startingSpaces == -1 {
            startingSpaces = 6
        }
        var count: Int = 1
        while(count <= 42) {
            
            if (count <= startingSpaces || count - startingSpaces > daysInMonth) {
                let calenderDay = CalenderDay(date: "", emptyDay: true)
                calenderDays.append(calenderDay)
            } else {
                let day = String(count - startingSpaces)
                let month = monthString(date: date)
                let year = yearString(date: date)
                let date = "\(day)\("-")\(month)\("-")\(year)"
                if date == CalendarHelper().dayMonthYearString(date: todayDate) {
                    calenderDays.append(CalenderDay(date: date, today: true))
                } else if date ==  CalendarHelper.shared.selectedDate {
                    calenderDays.append(CalenderDay(date: date, selectedDay: true))
                } else {
                    calenderDays.append(CalenderDay(date: date, emptyDay: true))
                }
            }
            count += 1
        }
        return calenderDays
    }
    
    

}
