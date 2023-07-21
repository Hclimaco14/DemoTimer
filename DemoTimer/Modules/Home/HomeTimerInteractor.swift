//
//  HomeTimerInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 07/07/23.
//  
//


import Foundation


protocol HomeTimerBusinessLogic {
    func loadInitialConfig()
    func getUserPreference()
}

class HomeTimerInteractor:  HomeTimerBusinessLogic {
    
    var presenter: HomeTimerPresentationLogic?
    var worker = HomeTimerWorker()
    
    func loadInitialConfig() {
        worker.loadInitialConfig()
    }
    
    func getUserPreference() {
        if let user = worker.getPreference() {
            presenter?.presentUserPreference(preference: user)
        }
    }
    
}
