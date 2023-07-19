//
//  MenuPresenter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 13/07/23.
//  
//

import UIKit

protocol MenuPresentationLogic {
    func presentMenuOptions(_ options: [MenuModel.MenuOption])
}

class MenuPresenter: MenuPresentationLogic {
    
    var view: MenuDisplayLogic?
    
    func presentMenuOptions(_ options: [MenuModel.MenuOption]) {
        
        view?.displayMenuOptions(options)
    }
}
