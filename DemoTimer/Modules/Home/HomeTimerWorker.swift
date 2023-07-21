//
//  HomeTimerWorker.swift
//  DemoTimer
//
//  Created by Hector Climaco on 20/07/23.
//

import Foundation

class HomeTimerWorker {
    
    
    func loadInitialConfig() {
        let modes = DefaultManager.shared.getModes()
        if modes.isEmpty {
            let _ = DefaultManager.shared.saveModes(arrayList: loadModes())
        }
        
        let configurations = DefaultManager.shared.getConfigurations()
        if configurations.isEmpty {
            let _ = DefaultManager.shared.saveConfigurations(arrayList: loadConfigurations())
        }
    }
    
    func getPreference() -> ConfigureModel.UserPreference? {
        return DefaultManager.shared.getUserPreference()
    }
    
    private func loadModes() -> [ConfigureModel.EnableMode] {
        let soundAndVibration = ConfigureModel.EnableMode(mode: .soundAndVibration, isOn: false)
        let onlySound = ConfigureModel.EnableMode(mode: .onlySound, isOn: false)
        let onlyVibration = ConfigureModel.EnableMode(mode: .onlyVibration, isOn: false)
        return [soundAndVibration,onlySound,onlyVibration]
    }
    
    private func loadConfigurations() -> [ConfigureModel.Configuration] {
        
        let soundOne = SoundAction(action: .sound1, isEnable: false)
        let soundTwo = SoundAction(action: .sound2, isEnable: false)
        let souds:[ConfigurationAction] = [soundOne,soundTwo]
        
        let soundConfiguration =  ConfigureModel.Configuration(type: .sound, configurations: souds)
        
        let vibrationOne = VibracionAction(action: .vabration1, isEnable: false )
        let vibrationTwo = VibracionAction(action: .vabration2, isEnable: false)
        let vibrationThree = VibracionAction(action: .vabration3, isEnable: false)
        
        let vibrations:[ConfigurationAction] = [vibrationOne, vibrationTwo, vibrationThree]
        
        let vibrationConfiguration =  ConfigureModel.Configuration(type: .vibration, configurations: vibrations)
        
        return [soundConfiguration, vibrationConfiguration]

    }
}
