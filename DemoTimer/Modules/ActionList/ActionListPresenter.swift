//
//  ActionListPresenter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 12/07/23.
//  
//

import UIKit

protocol ActionListPresentationLogic {
    func presentSomething(response: ActionList.Something.Response)
}

class ActionListPresenter: ActionListPresentationLogic {
    
    var view: ActionListDisplayLogic?
    
    func presentSomething(response: ActionList.Something.Response) {
        let viewModel = ActionList.Something.ViewModel()
        view?.displaySomething(viewModel: viewModel)
    }
}
