//
//  HomeTimerInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 07/07/23.
//  
//


import Foundation


protocol HomeTimerBusinessLogic {
    func doSomething()
}

class HomeTimerInteractor:  HomeTimerBusinessLogic {
    
    var presenter: HomeTimerPresentationLogic?
    
    func doSomething() {
        presenter?.presentSomething()
    }
    
}
