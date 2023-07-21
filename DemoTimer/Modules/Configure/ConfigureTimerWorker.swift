//
//  ConfigureTimerWorker.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//  
//

import UIKit

class ConfigureTimerWorker {
    
    func loadModes() -> [ConfigureModel.EnableMode] {
        return DefaultManager.shared.getModes()
    }
    
    func loadActions() -> [ConfigureModel.Configuration] {
        return DefaultManager.shared.getConfigurations()
    }
    
    func saveModes(mode: [ConfigureModel.EnableMode]) {
        let _ = DefaultManager.shared.saveModes(arrayList: mode)
        var user = DefaultManager.shared.getUserPreference() ?? ConfigureModel.UserPreference()
        
        let modeEnables = mode.filter({ $0.isOn })
        
        if modeEnables.count > 1 {
            user.mode = ConfigureModel.EnableMode(mode: .soundAndVibration, isOn: true)
        } else {
            user.mode = modeEnables.first ?? ConfigureModel.EnableMode(mode: .undefined, isOn: true)
        }
        
        let actions = loadActions()
        
        if let sound = actions.first(where: { $0.type == .sound })?.configureActions.first(where: { $0.isEnable }),
           let soundAction = SoundAction(id: sound.id, isEnable: sound.isEnable) {
            user.sound = soundAction
        }
        
        
        if let vibration = actions.first(where: { $0.type == .vibration })?
            .configureActions.first(where: { $0.isEnable }),
           let vibrationAction = VibracionAction(action: vibration) {
            user.vibration = vibrationAction
        }
        
        DefaultManager.shared.saveUserPreferences(object: user)
        
    }
}
