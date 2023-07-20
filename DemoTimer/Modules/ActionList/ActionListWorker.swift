//
//  ActionListWorker.swift
//  DemoTimer
//
//  Created by Hector Climaco on 12/07/23.
//  
//

import UIKit

class ActionListWorker {
    
    func updateSelection(configuration: ConfigureModel.Configuration) {
        var config = DefaultManager.shared.getConfigurations()
        if let index = config.firstIndex(where: { $0.type == configuration.type }) {
            config[index] = configuration
            let _ = DefaultManager.shared.saveConfigurations(arrayList: config)
        }
        
        if let action = configuration.configureActions.first(where: { $0.isEnable }) {
            var user = DefaultManager.shared.getUserPreference()
            
            if let sound = action as? SoundAction {
                user?.sound = sound
            }
            
            if let vibration = action as? VibracionAction {
                user?.vibration = vibration
            }
            
            if let userConfig = user {
                let _ = DefaultManager.shared.saveUserPreferences(object: userConfig)
            }
        }
        
    }
    
}
