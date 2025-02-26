//
//  ViewModel.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 26.02.2025.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var songs: [SongModel] = [
        SongModel(
            name: "Chasing Cars",
            data: Data(),
            artist: "System of a down",
            coverImage: Data(),
            duration: 0
        ),
        SongModel(
            name: "Vermollion",
            data: Data(),
            artist: "Slipknot",
            coverImage: Data(),
            duration: 0
        ),
        SongModel(
            name: "Fields of Gold",
            data: Data(),
            artist: "Sting",
            coverImage: Data(),
            duration: 0
        ),
    ]
    
}
