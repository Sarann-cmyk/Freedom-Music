//
//  BackgroundView.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 25.02.2025.
//

import SwiftUI

    struct BackgroundView: View {
        var body: some View {
            LinearGradient(
                colors: [.topBacground, .bottomBacground],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }


#Preview {
    BackgroundView()
}
