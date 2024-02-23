//
//  AudioSliderStyleView.swift
//  Assignments_POC
//
//  Created by Arjunan on 01/11/23.
//

import SwiftUI
import AVFoundation

struct AudioSliderStyleView: View {
    @State private var isPlaying = false
    @State private var currentTime: TimeInterval = 0
    @State private var timer: Timer?
    @State var playerItem: AVPlayerItem!
    let duration: TimeInterval = 60
    @State private var player: AVPlayer?
    init() {
        if let audioURL = audioURL {
            let playerItem = AVPlayerItem(url: audioURL)
            player = AVPlayer(playerItem: playerItem)
        }
    }
    let audioURL = URL(string: "http://example.com/your-audio-file.mp3") // Replace with your audio file's URL

    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 5) {
                HStack(spacing: 5) {
                    Button(action: {
                        isPlaying.toggle()
                        if isPlaying {
                            startTimer()
                        } else {
                            stopTimer()
                        }
                    }, label: {
                        Image(systemName: isPlaying ? "pause" : "play.fill")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color(hex: "#4B5563"))
                            .padding(10)
                    })
                    audioRecordingRectangleBuildingView
                }
                .padding(.vertical, 8)
                durationTimeView
            }
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: Color.gray.opacity(0.2), radius: 1.5, x: 0, y: 1)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .inset(by: -0.5)
                    .stroke(Color(hex: "#C2EBFA"), lineWidth: 1)
            )
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder var audioRecordingRectangleBuildingView: some View {
        HStack(spacing: 1) {
            ForEach(0..<30) { item in
                RoundedRectangle(cornerRadius: 2)
                    .frame(width: 6, height: brickHeightForTime(item))
                    .foregroundColor(brickColorForTime(item))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            currentTime += 1
            if currentTime >= duration {
                stopTimer()
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isPlaying = false
        currentTime = 0
    }
    
    func brickHeightForTime(_ brickIndex: Int) -> CGFloat {
        if isPlaying && Double(brickIndex) < (currentTime / duration) * 30 {
            return .random(in: 15...23)
        } else {
            return .random(in: 11...20)
        }
    }
    
    func brickColorForTime(_ brickIndex: Int) -> Color {
        if isPlaying && Double(brickIndex) < (currentTime / duration) * 30 {
            return Color.blue
        } else {
            return Color(hex: "#D9D9D9")
        }
    }
    
    var durationTimeView: some View {
        Text(String(format: "%.1f sec", currentTime))
            .padding(10)
            .font(.caption)
            .foregroundColor(Color(hex: "#4B5563"))
    }
    
//    func avplayerUrl(){
//        guard let songUrl = URL(string: "http://commondatastorage.googleapis.com/codeskulptor-demos/DDR_assets/Sevish_-__nbsp_.mp3" ) else {
//            return
//        }
//        playerItem = AVPlayerItem(url: songUrl)
//        player = AVPlayer(playerItem: playerItem)
//
//        let duration : CMTime = (self.player?.currentItem!.asset.duration)!
//        let seconds : Float64 = CMTimeGetSeconds(duration)
//        let maxTime : Float = Float(seconds)
//        self.slider.maximumValue = maxTime
//
//        let times  = Int(maxTime)
//        let durationTime = timeFormatted(totalSeconds: times)
//        itemDuration.text = durationTime
//
//    }
}

struct AudioSliderStyleView_Previews: PreviewProvider {
    static var previews: some View {
        AudioSliderStyleView()
    }
}
