//
//  ActionListRouter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 12/07/23.
//  
//


import UIKit

protocol ActionListRoutingLogic {
    func routeToSomewhere()
}

class ActionListRouter: ActionListRoutingLogic {
    
    var view: ActionListViewController?
    
    func routeToSomewhere() {
        
    }
    
}
