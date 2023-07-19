//
//  ActionListInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 12/07/23.
//  
//


import Foundation


protocol ActionListBusinessLogic {
    func doSomething(request: ActionList.Something.Request)
}

class ActionListInteractor:  ActionListBusinessLogic {
    
    var presenter: ActionListPresentationLogic?
    
    let worker = ActionListWorker()
    
    func doSomething(request: ActionList.Something.Request) {
        let response = ActionList.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
}
