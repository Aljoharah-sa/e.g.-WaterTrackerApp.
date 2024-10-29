//
//  SplashView.swift
//  e.g., WaterTrackerApp.
//
//  Created by ALJOAHARAH SAUD ALSAYARI on 26/04/1446 AH.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "drop.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)

            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
                .padding(.top, 10)
            Spacer()
        }
        .onAppear {
            // Delay for 3 seconds before moving to ContentView
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .background(
            NavigationLink(destination: ContentView(), isActive: $isActive) {
                EmptyView()
            }
        )
    }
}
