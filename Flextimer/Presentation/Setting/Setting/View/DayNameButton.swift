//
//  DayNameButton.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2020/01/11.
//  Copyright © 2020 Suzy Mararon Park. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class DayNameButton: UIButton {
  
  init(_ title: String, idx: Int) {
    super.init(frame: .zero)
    self.tag = idx
    self.isEnabled = RealmService.shared.userInfo.workdaysPerWeekIdxs.contains(idx)
    self.setBackgroundColor(color: Color.immutableOrange, forState: .selected)
    self.setBackgroundColor(color: Color.immutableLightGray, forState: .normal)
    self.setTitle(title, for: .normal)
    self.setTitleColor(Color.immutableWhite, for: .normal)
    self.layer.cornerRadius = 4
    self.clipsToBounds = true
    self.translatesAutoresizingMaskIntoConstraints = false
    self.widthAnchor.constraint(equalToConstant: (ScreenSize.width-100)/7).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func toggle() {
    let enableState = !(self.isEnabled)
    self.isEnabled = enableState
    self.updateRealm(self.tag)
  }
  
  fileprivate func updateRealm(_ idx: Int) {
    var workdaysPerWeekIdxs = [Int](RealmService.shared.userInfo.workdaysPerWeekIdxs)
    
    if workdaysPerWeekIdxs.contains(idx) {
      if let idx = workdaysPerWeekIdxs.firstIndex(of: idx) {
        workdaysPerWeekIdxs.remove(at: idx)
      }
    } else {
      workdaysPerWeekIdxs.append(idx)
    }
    
    let updateIdxs = workdaysPerWeekIdxs.sorted { $0 < $1 }
    RealmService.shared.update(
      RealmService.shared.userInfo,
      with: ["workdaysPerWeekIdxs": updateIdxs]
    )
    
    DispatchQueue.main.async {
      NotificationCenter.default.post(name: NSNotification.Name.didUpdateOptions, object: nil)
    }
  }
}
