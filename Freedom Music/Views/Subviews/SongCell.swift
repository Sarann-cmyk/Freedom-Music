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
    
    // MARK: - Body
    var body: some View {
        HStack {
            Color.white
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .nameFont()
                Text(song.artist ?? "Unknown Artist")
                    .artistFont()
                
            }
            
            Spacer()
            
            Text("03:48")
                .artistFont()
        }
        
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}


#Preview {
    SongCell(song: SongModel(name: "Hurt", data: Data(), artist: "Johnny Cash", coverImage: nil, duration: nil))
}
