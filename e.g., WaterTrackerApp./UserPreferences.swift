//
//  UserPreferences.swift
//  e.g., WaterTrackerApp.
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 18/04/1446 AH.
//

import Foundation

struct UserPreferences: Codable {
    // Properties that save to UserDefaults when updated
    var bodyWeight: Double {
        didSet {
            UserDefaults.standard.set(bodyWeight, forKey: "bodyWeight")
        }
    }
    var dailyWaterGoal: Double {
        didSet {
            UserDefaults.standard.set(dailyWaterGoal, forKey: "dailyWaterGoal")
        }
    }
    
    var notificationStartHour: Date
    var notificationEndHour: Date
    var notificationInterval: TimeInterval
    var currentIntake: Double
    
    // Computed property for daily water goal based on weight
    var calculatedDailyGoal: Double {
        return bodyWeight * 0.03 // Example: 0.03 liters per kg
    }
    
    // Load from UserDefaults or use default values if none are saved
    static var defaultPreferences: UserPreferences {
        return UserPreferences(
            bodyWeight: UserDefaults.standard.double(forKey: "bodyWeight") == 0 ? 70.0 : UserDefaults.standard.double(forKey: "bodyWeight"),
            dailyWaterGoal: UserDefaults.standard.double(forKey: "dailyWaterGoal") == 0 ? 2.1 : UserDefaults.standard.double(forKey: "dailyWaterGoal"),
            notificationStartHour: Calendar.current.startOfDay(for: Date()).addingTimeInterval(8 * 60 * 60), // default 8 AM
            notificationEndHour: Calendar.current.startOfDay(for: Date()).addingTimeInterval(20 * 60 * 60), // default 8 PM
            notificationInterval: 15 * 60, // default 15 minutes
            currentIntake: 0.0
        )
    }
}
