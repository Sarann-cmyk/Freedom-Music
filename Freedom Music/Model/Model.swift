//
//  Model.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 25.02.2025.
//

import Foundation

struct SongModel: Identifiable {
    var id = UUID()
    var name: String
    var data: Data
    var artist: String?
    var coverImage: Data?
    var duration: TimeInterval?
  
}
