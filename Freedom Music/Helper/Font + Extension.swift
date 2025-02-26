//
//  FontsView.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 25.02.2025.
//

import SwiftUI

extension Text {
    func nameFont() -> some View {
        self
            .foregroundColor(.white)
            .font(
                .system(
                    size: 16,
                    weight: .semibold,
                    design: .rounded)
            )
        
    }
    
    func artistFont() -> some View {
        self
            .foregroundColor(.white)
            .font(
                .system(
                    size: 14,
                    weight: .light,
                    design: .rounded)
            )
        
    }
}

struct FontsView: View {
    var body: some View {
        VStack {
            Text("Name Font")
                .nameFont()
            Text("Artist Font")
                .artistFont()
                
        }
    }
}

#Preview {
    FontsView()
}
