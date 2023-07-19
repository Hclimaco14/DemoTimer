//
//  ConfigureTimerRouter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//  
//


import UIKit

protocol ConfigureTimerRoutingLogic {
    func goToActionList(configuration: ConfigureModel.Configuration)
}

class ConfigureTimerRouter: ConfigureTimerRoutingLogic {
    
    var view: ConfigureTimerViewController?
    
    func goToActionList(configuration: ConfigureModel.Configuration) {
        let vc = ActionListViewController()
        vc.configureActions = configuration
        self.view?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
