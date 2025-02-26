//
//  ImportFileMenager.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 26.02.2025.
//

import Foundation
import SwiftUI


// ImportFileMenager - дозволяє вибирати аудіофайли та імпортувати їх у додаток
struct ImportFileMenager: UIViewControllerRepresentable {
    
    @Binding var songs: [SongModel]
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    // Метод який створює та налаштовує UIDocumentPickerViewController який використовуєтся для вибору аудиофайлів
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .import)
      
        
    }
    
    func updateUIViewController(_ uiView: UIViewControllerType, context: Context) {
        
    }

    // Координатор є зявзком між UIDocumentPicker та ImportFileMenager
    class Coordinator {
        
        
        // Це посилання на батьківський компонент ImportFileMenager щоб була можливість з ним взаємодіяти
        var parent: ImportFileMenager
        
        init(parent: ImportFileMenager) {
            self.parent = parent
        }
        
    }
}
