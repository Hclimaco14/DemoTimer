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
        let soundAndVibration = ConfigureModel.EnableMode(id: 1, name: "Sonido y Vibracion", isOn: false)
        let onlySound = ConfigureModel.EnableMode(id: 2, name: "Solo Sonido", isOn: false)
        let onlyVibration = ConfigureModel.EnableMode(id: 3, name: "Solo Vibracio", isOn: false)
        return [soundAndVibration,onlySound,onlyVibration]
    }
    
    func loadActions() -> [ConfigureModel.Configuration] {
        
        let soundOne = ConfigureModel.SoundAction(id: 1, isEnable: false, name: "Sonido 1", action: .sound1)
        let soundTwo = ConfigureModel.SoundAction(id: 2, isEnable: false, name: "Sonido 2", action: .sound2)
        let souds:[ConfigurationAction] = [soundOne,soundTwo]
        
        let soundConfiguration =  ConfigureModel.Configuration(name: "Sonidos", selection: "Selecionar", type: .sound, configurations: souds)
        
        let vibrationOne = ConfigureModel.VibracionAction(id: 1001, isEnable: false, name: "Vibracion 1", action: .vabration1)
        let vibrationTwo = ConfigureModel.VibracionAction(id: 1002, isEnable: false, name: "Vibracion 2", action: .vabration2)
        let vibrationThree = ConfigureModel.VibracionAction(id: 1003, isEnable: false, name: "Vibracion 3", action: .vabration3)
        
        let vibrations:[ConfigurationAction] = [vibrationOne, vibrationTwo, vibrationThree]
        
        let vibrationConfiguration =  ConfigureModel.Configuration(name: "Vibraciones", selection: "Selecionar", type: .vibration, configurations: vibrations)
        
        return [soundConfiguration, vibrationConfiguration]

    }
    
}
