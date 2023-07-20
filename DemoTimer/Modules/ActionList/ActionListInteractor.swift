//
//  ActionListInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 12/07/23.
//  
//


import Foundation


protocol ActionListBusinessLogic {
    func updateSelection(configuration: ConfigureModel.Configuration)
}

class ActionListInteractor:  ActionListBusinessLogic {
    
    var presenter: ActionListPresentationLogic?
    
    let worker = ActionListWorker()
    
    func updateSelection(configuration: ConfigureModel.Configuration) {
        worker.updateSelection(configuration: configuration)
    }
}
