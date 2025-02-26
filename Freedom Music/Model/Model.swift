//
//  Model.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 25.02.2025.
//

import Foundation

struct SongModel: Identifiable {
    let id = UUID()
    let name: String
    let data: Data
    let artist: String?
    let coverImage: Data?
    let duration: TimeInterval?
  
}
