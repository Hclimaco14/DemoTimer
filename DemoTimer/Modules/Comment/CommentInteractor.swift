//
//  CommentInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 20/07/23.
//  
//


import Foundation


protocol CommentBusinessLogic {
    func saveData(comment: CommentModel.Comment)
    func getComment()
}

class CommentInteractor:  CommentBusinessLogic {
    
    var presenter: CommentPresentationLogic?
    
    let worker = CommentWorker()
    
    func saveData(comment: CommentModel.Comment) {
        worker.saveComment(comment: comment)
    }
    
    func getComment() {
        if let comment = worker.getComment() {
            presenter?.presentComment(comment: comment)
        }
    }
}
