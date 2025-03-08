//
//  SongImageView.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 03.03.2025.
//

import SwiftUI

struct SongImageView: View {
    
    // MARK: - Propertise
    let imageData: Data?
    let size: CGFloat
    
    // MARK: - Body
    var body: some View {
        
        if let data = imageData, let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipShape(RoundedRectangle(cornerRadius: 10))
          // Якщо не буде coverImage, тоді показуй ось це...
        } else {
            ZStack {
                Color.gray
                    .frame(width: size, height: size)
                Image(systemName: "music.note")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: size / 2)
                    .foregroundColor(.white)
            }
            .cornerRadius(10)
            
        }
    }
}

#Preview {
    SongImageView(imageData: Data(), size: 200)
}
