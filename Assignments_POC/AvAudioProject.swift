//
//  DGAudioPlayer.swift
//  DigiStudennt
//
//  Created by apple on 05/03/21.
//  Copyright © 2021 Ragul kts. All rights reserved.
//

import Foundation
import AVKit

protocol DGAudioPlayerDelegate: AnyObject {
    func playbackTimeChanged(time: TimeInterval)
    func finishedPlaying()
    func preparedForPlay()
    func failedToPlay()
    func readyToPlay()
    func didClickPlay()
    func didClickPause()
}

class DGAudioPlayer: NSObject {
    
    static let shared = DGAudioPlayer()
    
    private var audioPlayer: AVPlayer?
    var playerItem:AVPlayerItem?
    var playerAsset: AVAsset?
    var timeObserver: Any?
    var notificationObserver: Any?
    
    private var playerItemContext = 0
    weak var delegate: DGAudioPlayerDelegate?
    var isLoading: Bool = false
    var audioId: String = ""
    var isPlaybackSlided: Bool = false
    
    private override init(){
        super.init()
    }
    func setupPlayer(url: String, id: String) {
        if let remoteURL = URL(string: url/*.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "" */) {
            resetPlayer()
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
            } catch(let error) {
                print(error.localizedDescription)
            }
            audioId = id
            let assetKeys = ["playable", "hasProtectedContent"]
            let asset = AVAsset(url: remoteURL)
            playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: assetKeys)
            playerItem?.addObserver(self,
                                       forKeyPath: #keyPath(AVPlayerItem.status),
                                       options: [.old, .new],
                                       context: &playerItemContext)
            audioPlayer = AVPlayer(playerItem: playerItem)
            notificationObserver = NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
            timeObserver = audioPlayer?.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { [weak self](_) -> Void in
                self?.playbackTimeChanged()
            }
            isLoading = true
            delegate?.preparedForPlay()
            self.play()
        } else {
            isLoading = false
            delegate?.failedToPlay()
        }
    }
    func resetPlayer() {
        playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), context: &playerItemContext)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        timeObserver = nil
        audioPlayer?.pause()
        playerAsset = nil
        playerItem = nil
        audioPlayer = nil
        isPlaybackSlided = false
    }
    func isNewFile(newId: String) -> Bool {
        return audioPlayer == nil || audioId != newId
    }
    func isPlaying() -> Bool {
        if (audioPlayer?.rate != 0 && audioPlayer?.error == nil) {
            return true
        } else {
            return false
        }
    }
    func play() {
        audioPlayer?.play()
        if audioPlayer?.error == nil {
            delegate?.didClickPlay()
        }
        
    }
    func pause() {
        audioPlayer?.pause()
        if audioPlayer?.error == nil {
            delegate?.didClickPause()
        }
    }
    var currentTime: TimeInterval {
        let current : CMTime = playerItem?.currentTime() ?? CMTime(seconds: 0, preferredTimescale: 1)
        let seconds : TimeInterval = CMTimeGetSeconds(current.isNumeric ? current : CMTime(seconds: 0, preferredTimescale: 1))
        return seconds
    }
    var duration: TimeInterval {
        
        let duration : CMTime = playerItem?.duration ?? CMTime(seconds: 0, preferredTimescale: 1)
        let seconds : TimeInterval = CMTimeGetSeconds(duration.isNumeric ? duration : CMTime(seconds: 0, preferredTimescale: 1))
        return seconds
    }
    
    func seekToTime(time: TimeInterval) {
        audioPlayer?.seek(to: CMTime(seconds: time, preferredTimescale: 1))
    }
    func playbackTimeChanged() {
        if !isPlaybackSlided {
            delegate?.playbackTimeChanged(time: currentTime)
        }
    }
    @objc func finishedPlaying() {
        audioPlayer?.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
        delegate?.finishedPlaying()
    }
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        // Only handle observations for the playerItemContext
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath,
                               of: object,
                               change: change,
                               context: context)
            
            return
        }
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            
            // Get the status change from the change dictionary
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            
            // Switch over the status
            switch status {
            case .readyToPlay:
            // Player item is ready to play.
                isLoading = false
                delegate?.readyToPlay()
            case .failed:
           //     log(playerItem?.error as Any)
                isLoading = false
                delegate?.failedToPlay()
            // Player item failed. See error.
            case .unknown:
                // Player item is not yet ready.
                isLoading = false
                delegate?.failedToPlay()
            @unknown default:
                isLoading = false
                fatalError()
            }
        }
    }
}
