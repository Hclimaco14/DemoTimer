//
//  CommentPresenter.swift
//  DemoTimer
//
//  Created by Hector Climaco on 20/07/23.
//  
//

import UIKit

protocol CommentPresentationLogic {
    func presentComment(comment: CommentModel.Comment)
}

class CommentPresenter: CommentPresentationLogic {
    
    var view: CommentDisplayLogic?
    
    func presentComment(comment: CommentModel.Comment) {
        view?.displayComment(comment: comment)
    }
    
}
