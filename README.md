# HydrateTrackerApp

HydrateTrackerApp is an iOS application designed to help users monitor their daily water intake. Based on the user’s body weight, the app calculates a personalized daily hydration goal and allows users to log water intake, receive reminders, and track their progress throughout the day. Built with SwiftUI, the app offers a user-friendly and visually engaging experience.

## Features

- **Personalized Hydration Goal**: Calculates daily water intake based on the user’s weight.
- **Progress Tracking**: Displays the user’s current water intake vs. daily goal in a visual format.
- **Customizable Reminders**: Allows users to set up notifications at intervals they choose, reminding them to drink water.
- **Persistent Data**: Saves user preferences (weight, daily goal, and notification settings) using UserDefaults, so information is retained between sessions.

## Screens

### 1. Splash Screen
A welcoming splash screen displays a water drop icon and “Welcome” text, adding a warm and engaging start to the app.

### 2. Onboarding Screen
The OnboardingView guides users through setting up their daily water goal by:
   - Entering body weight.
   - Displaying their personalized daily water intake goal.

### 3. Notification Settings Screen
The NotificationSettingsView allows users to:
   - Set start and end hours for notifications.
   - Choose reminder intervals (e.g., 15 mins, 30 mins, up to 5 hours).

### 4. Progress Screen
Displays the user’s water intake visually, showing:
   - The amount of water consumed vs. the daily goal.
   - A dynamically changing emoji representing progress milestones, adding fun and motivation to the hydration journey.

## Technical Overview

- **SwiftUI**: Used for building the UI in a declarative, modular way.
- **UserDefaults**: Used to persist user preferences and settings across app launches.
- **UNUserNotificationCenter**: Handles scheduling and displaying local notifications to remind users to drink water at intervals they select.
- **Data Binding and State Management**: SwiftUI’s `@State` and `@Binding` properties enable seamless updates between the UI and data models, making the app responsive to changes.
