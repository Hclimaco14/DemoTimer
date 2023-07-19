//
//  ConfigureTimerInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//  
//


import Foundation


protocol ConfigureTimerBusinessLogic {
    func loadModes()
    func loadConfigurations()
}

class ConfigureTimerInteractor:  ConfigureTimerBusinessLogic {
    
    var presenter: ConfigureTimerPresentationLogic?
    
    let worker = ConfigureTimerWorker()
    
    func loadModes() {
        presenter?.presentEnableModes(modes: worker.loadModes().sorted(by: { $0.id < $1.id }))
    }
    
    func loadConfigurations() {
        presenter?.presentConfigurations(configurations: worker.loadActions())
    }
    
}
