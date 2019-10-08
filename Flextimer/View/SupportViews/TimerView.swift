//
//  TimerView.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/08.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import SwiftUI

struct TimerView: View {
  @EnvironmentObject var userData: UserData
  let timer = MyTimer()
  
  @State private var currentTime: String = ""
  
  var body: some View {
    VStack {
      Text("\(currentTime)")
        .font(.largeTitle)
        .padding(.bottom, 4)
      
      HStack {
        Text("퇴근까지")
        Text("00시간 00분")
        Text("존버")
      }
      .foregroundColor(Color.gray.opacity(0.4))
    }
    .onReceive(timer.currentTimePublisher) { newCurrentTime in
      
      let interval = newCurrentTime.timeIntervalSince(
        self.userData.startDate ?? Date()
      )

      self.currentTime = interval.toReadableString()
    }
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView()
  }
}
