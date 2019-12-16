//
//  Date.swift
//  Flextimer
//
//  Created by Suzy Park on 2019/10/07.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation

extension Date {
  
  enum Weekday: String {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
  }
  
  static func datesOfThisWeek() -> [Date] {
    let calendar = Calendar.current
    var dates: [Date] = []
    var date = Date.getThisWeekMonday(Date())()
    let toDate = calendar.date(byAdding: .day, value: 6, to: date) ?? Date()
    
    while date <= toDate {
      dates.append(date)
      guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
      date = newDate
    }
    return dates
  }

  func getWeekdaysInEnglish() -> [String] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "en_US")
    return calendar.weekdaySymbols
  }
  
  // https://stackoverflow.com/questions/33397101/how-to-get-mondays-date-of-the-current-week-in-swift
  func getThisWeekMonday() -> Date {
    let monday = Weekday.monday.rawValue
    let weekdaysName = Date().getWeekdaysInEnglish().map { $0.lowercased() }
    let searchWeekdayIndex = weekdaysName.firstIndex(of: monday)! + 1
    let calendar = Calendar.current
    
    if (calendar.component(.weekday, from: self) == searchWeekdayIndex) {
      return self
    }
    
    var nextDateComponent = DateComponents()
    nextDateComponent.weekday = searchWeekdayIndex
    
    let date = calendar.nextDate(
      after: self,
      matching: nextDateComponent,
      matchingPolicy: .nextTime,
      direction: .backward)
    
    return date!
  }
}
