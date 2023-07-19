//
//  Constants.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//

import Foundation
import UIKit
import CoreHaptics
import AVFoundation

let spaceUnit    = 8

public enum SpaceUnits {
    public static let zero    = CGFloat(0)
    public static let quarter = CGFloat(spaceUnit/4)
    public static let half    = CGFloat(spaceUnit/2)
    public static let one     = CGFloat(spaceUnit)
    public static let two     = CGFloat(spaceUnit*2)
    public static let three   = CGFloat(spaceUnit*3)
    public static let four   = CGFloat(spaceUnit*4)
    public static let five    = CGFloat(spaceUnit*5)
    public static let ten     = CGFloat(spaceUnit*10)
}


public enum Coulors {
    public static let backgroundCell = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1.0)
    public static let background = UIColor.black
    public static let primaryButton = UIColor.systemYellow
    public static let secondaryButton = UIColor.systemRed
    public static let textButton = UIColor.white
    public static let textSelection = UIColor.lightGray
}


public enum Images {
    public static let arrow =  UIImage(named: "ArrowRight")?.withTintColor(Coulors.textSelection, renderingMode: .alwaysOriginal) ?? UIImage()
    public static let photoEmpty = UIImage(named: "profile_pic_empty") ?? UIImage()
    public static let checkmark = UIImage(systemName: "checkmark") ?? UIImage()
    public static let configureIcon = UIImage(systemName: "gearshape.fill")?.withTintColor(Coulors.textSelection, renderingMode: .alwaysOriginal)  ?? UIImage()
    public static let commentICon = UIImage(systemName: "text.bubble.fill")?.withTintColor(Coulors.textSelection, renderingMode: .alwaysOriginal) ?? UIImage()
}


public enum Vibration:Int,CaseIterable {
    case vabration1 = 1
    case vabration2 = 2
    case vabration3 = 3
    
    public func vibrate(engine: CHHapticEngine?) {
        
        switch self {
            
        case .vabration1:
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            let short3 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0.4)
            let long1 = CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: 0.6, duration: 0.5)
            let long3 = CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: 1.8, duration: 0.5)
            let short6 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 2.8)
            
            do {
                let pattern = try CHHapticPattern(events: [ short3, long1, long3, short6], parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
        case .vabration2:
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            let short1 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0)
            let short2 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0.2)
            let short3 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0.4)
            let long1 = CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: 0.6, duration: 0.5)
            let long2 = CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: 1.2, duration: 0.5)
            let long3 = CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: 1.8, duration: 0.5)
            let short4 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 2.4)
            let short5 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 2.6)
            let short6 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 2.8)
            
            do {
                let pattern = try CHHapticPattern(events: [short1, short2, short3, long1, long2, long3, short4, short5, short6], parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
        case .vabration3:
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            let short1 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0)
            
            let short3 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0.4)
            let long1 = CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: 0.6, duration: 0.5)
            
            let long3 = CHHapticEvent(eventType: .hapticContinuous, parameters: [], relativeTime: 1.8, duration: 0.5)
            let short4 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 2.4)
            
            let short6 = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 2.8)
            
            do {
                let pattern = try CHHapticPattern(events: [short1, short3, long1, long3, short4, short6], parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 2)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
        }
        
    }
}


public enum Sound: Int,CaseIterable {
    case sound1 = 1
    case sound2 = 2
    case sound3 = 3
    
    var value:String {
        switch self {
        case .sound1:
            return "alarm_gentle"
        case .sound2:
            return "alert_high-intensity"
        case .sound3:
            return "ringtone_minimal"
        }
    }
    
    public func soundPlay(soundEffect: inout AVAudioPlayer?) {
        
        if let url = Bundle.main.url(forResource: self.value, withExtension: "wav") {
            
            do {
                soundEffect = try AVAudioPlayer(contentsOf: url)
                soundEffect?.numberOfLoops = 1
                soundEffect?.play()
            } catch {
                print("Error in play sound")
            }
            
        } else {
            print("file \(self.value) not found")
        }
    }
}
