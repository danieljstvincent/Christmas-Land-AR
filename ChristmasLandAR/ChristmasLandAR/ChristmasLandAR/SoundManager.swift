//
//  SoundManager.swift
//  ChristmasLandAR
//
//  Created by Daniel St Vincent on 12/12/21.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

class SoundManager {
    static var audioPlayer: AVAudioPlayer?

    static func playSound(key: String) {
        let bundlePath = Bundle.main.path(forResource: key, ofType: "mp3")

        guard bundlePath != nil else {
            print("Couldn't find sound file \(key) in the bundle")
            return
        }

        //  Create a URL object from this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)

        do {
            //  Create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
//            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)

            //  Play the sound
            audioPlayer?.play()
            audioPlayer?.numberOfLoops = -1  // Loop continuously

        } catch {
            // Could not create audio player object
            print("Could not create the audio player object for sound file \(key). Error says: \(error).")
        }
    }

    static func stopPlaying() {
        audioPlayer?.stop()
    }
}
