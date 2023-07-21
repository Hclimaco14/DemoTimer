//
//  HomeTimerRouter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 07/07/23.
//  
//


import UIKit

protocol HomeTimerRoutingLogic {
    func goToConfiguration()
}

class HomeTimerRouter: HomeTimerRoutingLogic {
    
    var view: HomeTimerViewController?
    
    func goToConfiguration() {
        view?.navigationController?.pushViewController(ConfigureTimerViewController(), animated: true)
    }
}
