//
//  AppDelegate.swift
//  Flextimer
//
//  Created by Suzy Mararon Park on 2019/10/17.
//  Copyright © 2019 Suzy Mararon Park. All rights reserved.
//

import Foundation
import UIKit
//import Siren
import RealmSwift

extension SceneDelegate {
  
//  func setupSiren() {
//    let siren = Siren.shared
//    siren.wail()
//    siren.presentationManager = PresentationManager(forceLanguageLocalization: .korean)
//    siren.presentationManager = PresentationManager(alertTintColor: Color.immutableOrange, appName: "자율출퇴근러")
//    siren.rulesManager = RulesManager(globalRules: .critical)
//  }
  
  func initializeRealm() {
        let config = Realm.Configuration(
      fileURL: Realm.Configuration.defaultConfiguration.fileURL!,
      schemaVersion: 1,
      // Set the block which will be called automatically when opening a Realm with
      // a schema version lower than the one set above
      migrationBlock: { migration, oldSchemaVersion in
        // We haven’t migrated anything yet, so oldSchemaVersion == 0
        if (oldSchemaVersion < 1) {
          // Nothing to do!
          // Realm will automatically detect new properties and removed properties
          // And will update the schema on disk automatically
        }
    })
    
    do {
      let _ = try Realm(configuration: config)
      Logger.complete("Realm has been configured")
    } catch let error as NSError {
      Logger.debug(error.localizedDescription)
    }
    
    
  }

  func appAppearanceCofigure() {
    UINavigationBar.appearance().tintColor = Color.immutableOrange
  }
}