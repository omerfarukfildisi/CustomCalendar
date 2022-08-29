//
//  CalendarModel.swift
//  Calendar
//
//  Created by Ömer Fildişi on 23.08.2022.
//

import Foundation


class CalenderDay {
    let date: String?
    let emptyDay: Bool?
    let today: Bool?
    let selectedDay: Bool?
    
    init(date:String, emptyDay: Bool = false, today: Bool = false, selectedDay: Bool = false) {
        self.date = date
        self.emptyDay = emptyDay
        self.today = today
        self.selectedDay = selectedDay
    }
}

