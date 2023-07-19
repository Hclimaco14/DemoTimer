//
//  ConfigureTimerPresenter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//  
//

import UIKit

protocol ConfigureTimerPresentationLogic {
    func presentEnableModes(modes: [ConfigureModel.EnableMode])
    func presentConfigurations(configurations: [ConfigureModel.Configuration])
}

class ConfigureTimerPresenter: ConfigureTimerPresentationLogic {
    
    var view: ConfigureTimerDisplayLogic?
    
    func presentEnableModes(modes: [ConfigureModel.EnableMode]) {
        view?.displayEnableModes(modes: modes)
    }
    
    func presentConfigurations(configurations: [ConfigureModel.Configuration]) {
        
        view?.displayConfigurations(configurations: configurations)
    }
}
