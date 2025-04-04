//
//  Freedom_MusicApp.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 25.02.2025.
//

import SwiftUI


@main
struct Freedom_MusicApp: App {
    var body: some Scene {
        WindowGroup {
            let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path())
            PlayerView()
        }
    }
}
