//
//  MenuInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 13/07/23.
//  
//


import Foundation


protocol MenuBusinessLogic {
    func getMenuOptions()
}

class MenuInteractor:  MenuBusinessLogic {
    
    var presenter: MenuPresentationLogic?
    
    let worker = MenuWorker()
    
    func getMenuOptions() {
        
        presenter?.presentMenuOptions(worker.getOptions())
    }
    
}
