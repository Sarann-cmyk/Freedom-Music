//
//  SongCell.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 25.02.2025.
//

import SwiftUI

struct SongCell: View {
    
    // MARK: - Properties
    let song: SongModel
    let durationFormated: (TimeInterval) -> String
    
    // MARK: - Body
    var body: some View {
        HStack {
            
            SongImageView(imageData: song.coverImage, size: 60)

            VStack(alignment: .leading) {
                Text(song.name)
                    .nameFont()
                Text(song.artist ?? "Unknown Artist")
                    .artistFont()
                
            }
            
            Spacer()
            
            if let duration = song.duration {
                Text(durationFormated(duration))
                    .artistFont()
                
                
                
            }
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}


#Preview {
   PlayerView()
}
