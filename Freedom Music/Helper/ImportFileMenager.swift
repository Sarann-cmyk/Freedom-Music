//
//  ImportFileMenager.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 26.02.2025.
//

import Foundation
import SwiftUI
import AVFoundation


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
        
        // Цей метод викликлаєтся коли користувач обирає пісню
        // Так цей метод опрацьовує та створює пісню типом SongModel та потім додає пісню до масиву SongModel
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            
            // guard let безпечно витягуе перший елемент з масиву urls. Якщо масив порожній, тоді urlі.first поверне nil і умова не буде виконаною та приведе до виходу з методу documentPicker
            // Пічля витягу url, метод startAccessingSecurityScopedResource викликаєтся для початку доступу к захищенному ресурсу
            guard let url = urls.first, url.startAccessingSecurityScopedResource() else { return }
            
            // Гарантує що метод stopAccessingSecurityScopedResource буде викликаний коли виконання documentPicker завершится, незалежно від того успішно чи ні, та ресурс безпеки буде закрито та коректно звільненно з памяті.
            defer { url.stopAccessingSecurityScopedResource() }
            
            do {
                
                // Отриманя даних файлу
                let document = try Data(contentsOf: url)
                   
                // Створення AVAsset для отримання метаданних
                let asset = AVAsset(url: url)
                
                // Ініціалізуємо обєкт SongModel
                var song = SongModel(name: url.lastPathComponent, data: document)
                
                // Це цикл для ітерації по метаданним щоб витягти з файлу - виконавця, обкладинку, та назву.
                let metadata = asset.metadata
                for item in metadata {
                    
                    // Перевірка на наявність меиоданних у файла через ключ / значення
                    guard let key = item.commonKey?.rawValue, let value = item.value else { continue }
                    switch key {
                    case AVMetadataKey.commonKeyArtist.rawValue:
                        song.artist = value as? String
                    case AVMetadataKey.commonKeyArtwork.rawValue:
                        song.coverImage = value as? Data
                        case AVMetadataKey.commonKeyTitle.rawValue:
                        song.name = value as? String ?? song.name
                    default:
                        break
                    }
                }
                
                // Отримання тривалості пісні
                song.duration = CMTimeGetSeconds(asset.duration)
                
                // Додавання пісні в масив song якщо там ще такої немає
                if !self.parent.songs.contains(where: { $0.name == song.name }) {
                    DispatchQueue.main.async {
                        self.parent.songs.append(song)
                    }
                } else {
                    print("Song with name \(song.name) already exist")
                }   
                
            } catch {
                print("Error processing the file: \(error)")
            }
        }
    }
}
