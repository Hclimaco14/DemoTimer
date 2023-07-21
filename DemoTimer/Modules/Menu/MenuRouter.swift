//
//  MenuRouter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 13/07/23.
//  
//


import UIKit

protocol MenuRoutingLogic {
    func goToConfiguration()
    func goToComments()
}

class MenuRouter: MenuRoutingLogic {
    
    var view: MenuViewController?
    
    func goToConfiguration() {
        view?.navigationController?.pushViewController(ConfigureTimerViewController(), animated: true)
    }
    
    func goToComments() {
        let vc = CommentViewController()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
