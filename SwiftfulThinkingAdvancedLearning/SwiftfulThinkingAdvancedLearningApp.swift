//
//  SwiftfulThinkingAdvancedLearningApp.swift
//  SwiftfulThinkingAdvancedLearning
//
//  Created by Nick Sarno on 8/23/21.
//

import SwiftUI

@main
struct SwiftfulThinkingAdvancedLearningApp: App {
    
    let currentUserIsSignedIn: Bool
    
    init() {
        //let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
        //let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"]
        //let userIsSignedIn: Bool = value == "true" ? true : false
        self.currentUserIsSignedIn = userIsSignedIn
    }
    
    var body: some Scene {
        WindowGroup {
//            CloudKitPushNotificationBootcamp()
//            CloudKitCrudBootcamp()
//            CloudKitUserBootcamp()
//            UITestingBootcampView(currentUserIsSignedIn: currentUserIsSignedIn)
        }
    }
}
