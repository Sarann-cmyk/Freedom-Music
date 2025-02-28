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
        
        // Дозвіл відкривати файли з типом "public.audio"
        let picker = UIDocumentPickerViewController(documentTypes: ["public.audio"], in: .open)
        
        // Дозвіл вибирати тільки один файл
        picker.allowsMultipleSelection = false
        
        // Дозвіл показувати тип файлу
        picker.shouldShowFileExtensions = true
        
        // Встановлення координатора в якості делегата
        picker.delegate = context.coordinator
         
        return picker
    }
    
    func updateUIViewController(_ uiView: UIViewControllerType, context: Context) {
        
    }

    // Координатор є зявзком між UIDocumentPicker та ImportFileMenager
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        
        
        // Це посилання на батьківський компонент ImportFileMenager щоб була можливість з ним взаємодіяти
        var parent: ImportFileMenager
        
        init(parent: ImportFileMenager) {
            self.parent = parent
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            
        }
    }
}
