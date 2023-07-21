//
//  CommentInteractor.swift
//  DemoTimer
//
//  Created by Hector Climaco on 20/07/23.
//  
//


import Foundation


protocol CommentBusinessLogic {
    
}

class CommentInteractor:  CommentBusinessLogic {
    
    var presenter: CommentPresentationLogic?
    
    let worker = CommentWorker()
    

    
}
