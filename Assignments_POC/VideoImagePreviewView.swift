//
//  ViewCommentsView.swift
//  DigiStudennt
//
//  Created by Arjunan on 17/11/23.
//  Copyright © 2023 Ragul kts. All rights reserved.
//

//import SwiftUI
//import AVFoundation
//import AVKit
//
//struct PlayerView: View {
//
//    var videoLink : String
//
//    @State private var player : AVPlayer?
//    @Binding var isPreviewVideo: Bool
//
//    var body: some View {
//        ZStack {
//            VStack(spacing: 0) {
//                    headerView
//                VideoPlayer(player: player) {
//                    
//                }
//                
//                .onAppear() {
//                    guard let url = URL(string: videoLink) else {
//                        return
//                    }
//                    player = AVPlayer(url: url)
//                    player?.play()
//                }
//                .onDisappear() {
//                    player?.pause()
//                }
//            }
//        }
//        .frame(maxWidth: .infinity,maxHeight: .infinity)
//    }
//    @ViewBuilder var headerView: some View {
//        HStack {
//            Button(action: {
//                isPreviewVideo = false
//            }, label: {
//                Image(systemName: "xmark")
//                    .resizable()
//                    .frame(width: 20,height: 20)
//                    .foregroundColor(Color.blue)
//            })
//            Spacer()
//        }
//        .padding(10)
//        .padding(.horizontal)
//        .foregroundColor(Color.white)
//        .background(Color.white)
//        .onTapGesture {
//        }
//    }
//}
//
//struct PreviewView: View {
//    var previewUrl : String?
//    @Binding var isPreviewImage: Bool
//
//    var body: some View {
//        ZStack {
//            Color.white
//            VStack {
//                headerView
//                contentView
//            }
//        }
//    }
//
//    @ViewBuilder var headerView: some View {
//        HStack {
//            Button(action: {
//                isPreviewImage = false
//            }, label: {
//                Image(systemName: "xmark")
//                    .resizable()
//                    .frame(width: 20,height: 20)
//                    .foregroundColor(Color.blue)
//            })
//            Spacer()
//        }
//        .padding(10)
//        .padding(.horizontal)
//        .background(Color.white)
//    }
//
//    @ViewBuilder var contentView: some View {
//        VStack {
//            if let url = URL(string: previewUrl ?? "") {
//                PreviewController(url:url)
//            }
//        }
//        .frame(maxWidth: .infinity,maxHeight: .infinity)
//    }
//}

