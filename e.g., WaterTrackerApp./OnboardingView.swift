//
//  OnboardingView.swift
//  e.g., WaterTrackerApp.
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 18/04/1446 AH.
//
import SwiftUI

struct OnboardingView: View {
    @Binding var userPreferences: UserPreferences
    @State private var weightInput: String = ""
    @State private var calculatedGoal: Double? = nil
    @State private var navigateToNotificationSettings = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Hydrate")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                
                Text("Start with Hydrate to record and track your water intake daily based on your needs and stay hydrated.")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                
                TextField("Body weight", text: $weightInput)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .onChange(of: weightInput) { _ in
                        // Check if the input is valid to enable the button
                        checkIfWeightIsValid()
                    }
                
                if let goal = calculatedGoal {
                    Text("Your Daily Water Goal: \(goal, specifier: "%.2f") L")
                        .padding(.horizontal, 16)
                        .font(.headline)
                        .padding(.top, 8)
                }
                
                Spacer()
                
                // Calculate/Next Button
                Button(action: {
                    if calculatedGoal == nil {
                        calculateGoal()
                    } else {
                        navigateToNotificationSettings = true
                    }
                }) {
                    Text(calculatedGoal == nil ? "Calculate Now" : "Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isWeightValid() ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                }
                .disabled(!isWeightValid()) // Disable button if input is invalid
                
                // NavigationLink to NotificationSettingsView
                NavigationLink(destination: NotificationSettingsView(userPreferences: $userPreferences), isActive: $navigateToNotificationSettings) {
                    EmptyView()
                }
            }
            .navigationTitle("Hydrate")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Check if weight input is valid (non-empty and a positive number)
    private func isWeightValid() -> Bool {
        if let weight = Double(weightInput), weight > 0 {
            return true
        }
        return false
    }
    
    // Calculate daily goal based on weight and display the result
    private func calculateGoal() {
        if let weight = Double(weightInput), weight > 0 {
            userPreferences.bodyWeight = weight
            userPreferences.dailyWaterGoal = weight * 0.03
            calculatedGoal = userPreferences.dailyWaterGoal
        }
    }
    
    // Called whenever the weight input changes
    private func checkIfWeightIsValid() {
        _ = isWeightValid()
    }
}
