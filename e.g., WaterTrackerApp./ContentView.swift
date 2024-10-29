//
//  ContentView.swift
//  e.g., WaterTrackerApp.
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 18/04/1446 AH.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    @State private var userPreferences = UserPreferences.defaultPreferences

    var body: some View {
        NavigationView {
            OnboardingView(userPreferences: $userPreferences)
                .onAppear {
                    requestNotificationPermission()
                }
        }
    }

    // Request notification permissions
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error.localizedDescription)")
            } else if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
}
