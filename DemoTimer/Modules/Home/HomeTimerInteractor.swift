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
}

class HomeTimerInteractor:  HomeTimerBusinessLogic {
    
    var presenter: HomeTimerPresentationLogic?
    var worker = HomeTimerWorker()
    
    func loadInitialConfig() {
        worker.loadInitialConfig()
    }
    
}
