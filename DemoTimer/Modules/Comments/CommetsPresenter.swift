//
//  CommentsPresenter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 11/07/23.
//  
//

import UIKit

protocol CommentsPresentationLogic {
    func presentSomething(response: Comments.Something.Response)
}

class CommentsPresenter: CommentsPresentationLogic {
    
    var view: CommentsDisplayLogic?
    
    func presentSomething(response: Comments.Something.Response) {
        let viewModel = Comments.Something.ViewModel()
        view?.displaySomething(viewModel: viewModel)
    }
}
