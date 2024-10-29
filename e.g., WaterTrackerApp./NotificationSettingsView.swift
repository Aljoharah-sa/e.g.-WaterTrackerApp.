//
//  NotificationSettingsView.swift
//  e.g., WaterTrackerApp.
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 18/04/1446 AH.
//
import SwiftUI
import UserNotifications

struct NotificationSettingsView: View {
    @Binding var userPreferences: UserPreferences
    @State private var navigateToProgressView = false
    
    let intervals = [
        (label: "15 Mins", value: 15.0 * 60),
        (label: "30 Mins", value: 30.0 * 60),
        (label: "60 Mins", value: 60.0 * 60),
        (label: "90 Mins", value: 90.0 * 60),
        (label: "2 Hours", value: 2.0 * 60 * 60),
        (label: "3 Hours", value: 3.0 * 60 * 60),
        (label: "4 Hours", value: 4.0 * 60 * 60),
        (label: "5 Hours", value: 5.0 * 60 * 60)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Notification Preferences")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            // Start and End Hour Selection
            VStack(alignment: .leading, spacing: 5) {
                Text("The start and end hour")
                    .font(.headline)
                    .padding(.horizontal)
                
                DatePicker("Start hour", selection: $userPreferences.notificationStartHour, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                DatePicker("End hour", selection: $userPreferences.notificationEndHour, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.compact)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            
            // Notification Interval Selection
            VStack(alignment: .leading, spacing: 5) {
                Text("Notification interval")
                    .font(.headline)
                    .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    ForEach(intervals, id: \.value) { interval in
                        Button(action: {
                            userPreferences.notificationInterval = interval.value
                        }) {
                            Text(interval.label)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(userPreferences.notificationInterval == interval.value ? Color.blue : Color.blue.opacity(0.2))
                                .foregroundColor(userPreferences.notificationInterval == interval.value ? .white : .blue)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
            // Start Button for Navigation and Notification Scheduling
            NavigationLink(destination: ProgressView(userPreferences: $userPreferences), isActive: $navigateToProgressView) {
                Button(action: {
                    scheduleNotifications()
                    navigateToProgressView = true
                }) {
                    Text("Start")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom, 20)
        }
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Schedule a single notification for testing
    func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Time to Drink Water!"
        content.body = "Stay hydrated! Remember to drink some water."
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) // 10 seconds for testing
        let request = UNNotificationRequest(identifier: "HydrateReminder", content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error.localizedDescription)")
            } else {
                print("Scheduled single notification for testing.")
            }
        }
    }
}
