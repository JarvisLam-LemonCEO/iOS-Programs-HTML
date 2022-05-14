//
//  PomodoroTimerAppApp.swift
//  PomodoroTimerApp
//
//  Created by Jarvis Lam on 5/13/22.
//

import SwiftUI

@main
struct PomodoroTimerAppApp: App {
    // since we are doing background fetching initializing here
    @StateObject var pomodoroModel: PomodoroModel = .init()
    // sene phase
    @Environment(\.scenePhase) var phase
    // storing last time stamp
    @State var lastActiveTimeStamp: Date = Date()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(pomodoroModel)
        }
        .onChange(of: phase) { newValue in
            if pomodoroModel.isStarted{
                if newValue == .background{
                    lastActiveTimeStamp = Date()
                }
                
                if newValue == .active {
                    // finding the difference
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveTimeStamp)
                    if pomodoroModel.totalSeconds - Int(currentTimeStampDiff) <= 0{
                        pomodoroModel.isStarted = false
                        pomodoroModel.totalSeconds = 0
                        pomodoroModel.isFinished = true
                        
                    } else {
                        pomodoroModel.totalSeconds -= Int(currentTimeStampDiff)
                    }
                    
                }
            }
        }
    }
}
