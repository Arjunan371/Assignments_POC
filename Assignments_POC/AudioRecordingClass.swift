import AVFoundation

class AudioRecorder: NSObject, ObservableObject, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder?
    var audioUrl: ((String) -> Void )?
    var audioRecordUrl: URL?
    var audioDuration: TimeInterval = 0
var isRecording: Bool = false

    func startRecording() {
        let session = AVAudioSession.sharedInstance()

        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [])
            try session.setActive(true)
            let urls = getDocumentsDirectory().appendingPathComponent("audioRecording.wav")
            let settings: [String: Any] = [
                                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                //          AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                          AVSampleRateKey: 44100.0,
                          AVNumberOfChannelsKey: 2,
                          AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                      ]
            audioRecorder = try? AVAudioRecorder(url: urls, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            isRecording = true
        } catch let error {
            debugPrint(error)
            print("Error recording audio: \(error.localizedDescription)")
        }
    }

    
    func stopRecording() {
        audioRecorder?.stop()
        audioRecordUrl = audioRecorder?.url
        isRecording = false
        print("Audio duration: \(audioDuration) seconds")
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording finished successfully.")
        } else {
            print("Recording failed.")
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

}




