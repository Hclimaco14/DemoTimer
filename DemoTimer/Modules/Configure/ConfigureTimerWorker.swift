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
        var user = DefaultManager.shared.getUserPreference()
    }
}
