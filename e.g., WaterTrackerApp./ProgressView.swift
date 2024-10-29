//
//  ProgressView.swift
//  e.g., WaterTrackerApp.
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 18/04/1446 AH.
//
import SwiftUI

struct ProgressView: View {
    @Binding var userPreferences: UserPreferences

    // Function to determine the emoji based on progress
    private func getProgressEmoji() -> String {
        let progress = userPreferences.currentIntake / userPreferences.dailyWaterGoal
        if progress == 0 {
            return "💤" // Zzz for 0% progress
        } else if progress < 0.25 {
            return "🐢" // Turtle for <25% progress
        } else if progress < 0.75 {
            return "🐇" // Rabbit for <75% progress
        } else if progress >= 1 {
            return "👏" // Clapping hands for 100% progress
        } else {
            return "🐇" // Default to rabbit if progress is between 25% and 100%
        }
    }

    var body: some View {
        VStack {
            Text("Today's Water Intake")
                .font(.headline)
                .padding(.top, 20)
            
            Text("\(userPreferences.currentIntake, specifier: "%.1f") liter / \(userPreferences.dailyWaterGoal, specifier: "%.1f") liter")
                .font(.subheadline)
            
            ZStack {
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(userPreferences.currentIntake / userPreferences.dailyWaterGoal, 1.0)))
                    .stroke(Color.blue, lineWidth: 10)
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 150, height: 150)
                
                Text(getProgressEmoji()) // Display the appropriate emoji
                    .font(.largeTitle)
            }
            .padding()
            
            HStack {
                Button(action: {
                    if userPreferences.currentIntake > 0 {
                        userPreferences.currentIntake -= 0.1
                    }
                }) {
                    Text("-")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.7))
                        .cornerRadius(10)
                }
                
                Text("\(userPreferences.currentIntake, specifier: "%.1f") L")
                    .font(.title)
                
                Button(action: {
                    if userPreferences.currentIntake < userPreferences.dailyWaterGoal {
                        userPreferences.currentIntake += 0.1
                    }
                }) {
                    Text("+")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

// Preview for ProgressView
struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(userPreferences: .constant(UserPreferences.defaultPreferences))
    }
}
