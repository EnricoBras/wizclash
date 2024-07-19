import Foundation
import AVFoundation

// Funzione per creare un player audio
func createAudioPlayer(forResource resource: String, withExtension ext: String) -> AVAudioPlayer? {
    guard let url = Bundle.main.url(forResource: resource, withExtension: ext) else {
        print("File audio \(resource).\(ext) non trovato")
        return nil
    }
    
    do {
        let audioPlayer = try AVAudioPlayer(contentsOf: url)
        return audioPlayer
    } catch {
        print("Errore nella creazione dell'audio player per \(resource).\(ext): \(error.localizedDescription)")
        return nil
    }
}

// Creazione dei player audio
var menuPlayer: AVAudioPlayer? = createAudioPlayer(forResource: "Menu", withExtension: "mp3")
var fightPlayer: AVAudioPlayer? = createAudioPlayer(forResource: "Fight", withExtension: "mp3")
var errorPlayer: AVAudioPlayer? = createAudioPlayer(forResource: "error", withExtension: "mp3")

class AudioManager {
    static let shared = AudioManager()
    var audioPlayer: AVAudioPlayer?

    private init() {}

    func playBackgroundMusic(forResource resource: String, withExtension ext: String) {
        guard let url = Bundle.main.url(forResource: resource, withExtension: ext) else {
            print("File audio di sottofondo \(resource).\(ext) non trovato")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Loop indefinitamente
            audioPlayer?.play()
        } catch {
            print("Errore nella riproduzione della musica di sottofondo: \(error.localizedDescription)")
        }
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
    
    func playSoundEffect(player: AVAudioPlayer?) {
        player?.play()
    }
}
