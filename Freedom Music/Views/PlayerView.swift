//
//  ContentView.swift
//  Freedom Music
//
//  Created by Aleks Synelnyk on 25.02.2025.
//

import SwiftUI
import RealmSwift
import AVFoundation


struct PlayerView: View {
    
    
    
    // MARK: - Properties
    @ObservedResults(SongModel.self) var songs
    @StateObject var vm = ViewModel()
    @State private var showFiles = false
    @State private var showFullPlayer = true
    @Namespace private var playerAnimation

    
    
    
    
    
    var frameImage: CGFloat {
        showFullPlayer ? 320 : 50
    }
    

    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    // List Of Songs
                    List {
                        ForEach (songs) { song in
                            SongCell(song: song, durationFormated:vm.durationFormated)
                                .onTapGesture {
                                    vm.playAudio(song: song)
                                }
                          }
                        .onDelete(perform: $songs.remove)
                    }
                    .listStyle(.plain)
                    
                    Spacer()
                    
                    // MARK: Player
                    if vm.currentSong != nil {
                        Player()
                        .frame(height: showFullPlayer ? SizeConstant.fullPlayer : SizeConstant.miniPlayer)
                        .onTapGesture {
                            withAnimation(.spring) {
                                self.showFullPlayer.toggle()
                            }
                        }
                    }
                }
            }
            
            // MARK: - Navigation Bar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFiles.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundStyle(.white)
                    }
                }
            }
            
            // MARK: Files Sheet
            .sheet(isPresented: $showFiles, content: {
                ImportFileMenager()
            })
        }
    }
    
    // MARK: - Methods
    
    // @ViewBuilder
    private func Player() -> some View {
        VStack {
            
            // Mini Player
            HStack {
                // Cover
                
                SongImageView(imageData: vm.currentSong?.coverImage, size: frameImage)
                
               
                // Якщо showFullPlayer fals тоді покажи міні версію плеера
                if !showFullPlayer {
                    
                    // Discription
                    VStack(alignment: .leading) {
                        SongDescription()
                    }
                    
                    .matchedGeometryEffect(id: "Discription", in: playerAnimation)
                    
                    Spacer()
                    CustomButton(image: vm.isPlaying ? "pause.fill" : "play.fill", size: .title) {
                        vm.playPause()
                    }
                }
            }
            .padding()
            .background(showFullPlayer ? .clear : .black.opacity(0.3))
            .cornerRadius(10)
            .padding()
            
            // MARK: - Full Player
            if showFullPlayer {
                
                //Description
                VStack {
                    SongDescription()
                }
                .padding()
                .matchedGeometryEffect(id: "Discription", in: playerAnimation)
                .padding(.top)
                
                VStack {
                    // Duration
                    HStack {
                        Text("\(vm.durationFormated(vm.currentTime))")
                        Spacer()
                        Text("\(vm.durationFormated(vm.totalTime))")
                    }
                    .durationFont()
                    .padding()
                    
                    // Slider
                    Slider(value: $vm.currentTime, in: 0...vm.totalTime) { editing in
                     
                        
                        if !editing {
                            vm.seekAudio(time: vm.currentTime)
                        }
                    }
                    .offset(y: -18)
                    .accentColor(.white)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true ) { _ in
                            vm.updateProgress()
                        }
                    }
                    
                    HStack(spacing: 40) {
                        
                        CustomButton(image: "gobackward.10", size: .title2) {
                            vm.skipBackward(by: 10)
                        }
                        
                        CustomButton(image: "backward.end.fill", size: .title2) {
                            vm.backward()
                        }
                        
                        CustomButton(image: vm.isPlaying ? "pause.circle.fill" : "play.circle.fill", size: .largeTitle) {
                            vm.playPause()
                        }
                        
                        CustomButton(image: "forward.end.fill", size: .title2) {
                            vm.forward()
                        }
                        
                        CustomButton(image: "goforward.10", size: .title2) {
                            vm.skipForward(by: 10)
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
        }
    }
    

    
    
    private func CustomButton(image: String, size: Font, action: @escaping () -> () ) -> some
    View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundColor(.white)
                .font(size)
        }
    }
    
    @ViewBuilder
    private func SongDescription() -> some View {
        if let currentSong = vm.currentSong {
            Text(currentSong.name)
                .nameFont()
            Text(currentSong.artist ?? "Unknown Artist")
                .artistFont()
        }
    }
}

#Preview {
    PlayerView()
}


