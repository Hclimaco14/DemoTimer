//
//  CommentsInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 11/07/23.
//  
//


import Foundation


protocol CommentsBusinessLogic {
    func doSomething(request: Comments.Something.Request)
}

class CommentsInteractor:  CommentsBusinessLogic {
    
    var presenter: CommentsPresentationLogic?
    
    let worker = CommentsWorker()
    
    func doSomething(request: Comments.Something.Request) {
        let response = Comments.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
}
