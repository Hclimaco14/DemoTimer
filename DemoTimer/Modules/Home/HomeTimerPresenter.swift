//
//  HomeTimerPresenter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 07/07/23.
//  
//

import UIKit

protocol HomeTimerPresentationLogic {
    func presentSomething()
}

class HomeTimerPresenter: HomeTimerPresentationLogic {
    
    var view: HomeTimerDisplayLogic?
    
    func presentSomething() {
        view?.displaySomething()
    }
}
