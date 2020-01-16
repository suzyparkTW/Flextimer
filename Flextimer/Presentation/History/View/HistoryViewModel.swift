//
//  HistoryViewModel.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/17.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import Foundation

class HistoryViewModel {
  
  let date: Date
  let workRecord: WorkRecord?
  
  init(_ date: Date) {
    
    self.date = date
    
    self.workRecord = RealmService.shared.realm
      .objects(WorkRecord.self)
      .filter { Calendar.current.isDate($0.startDate, inSameDayAs: date) && $0.endDate != nil }
      .last ?? nil
  }
  
}
