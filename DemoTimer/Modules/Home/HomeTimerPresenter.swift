//
//  HomeTimerPresenter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 07/07/23.
//  
//

import UIKit

protocol HomeTimerPresentationLogic {
    func presentUserPreference(preference: ConfigureModel.UserPreference)
}

class HomeTimerPresenter: HomeTimerPresentationLogic {
    
    var view: HomeTimerDisplayLogic?
    
    func presentUserPreference(preference: ConfigureModel.UserPreference) {
        view?.displayUserPreference(preference: preference)
    }
}
