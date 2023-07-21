//
//  CommentWorker.swift
//  DemoTimer
//
//  Created by Hector Climaco on 20/07/23.
//  
//

import UIKit

class CommentWorker {
    
    func saveComment(comment: CommentModel.Comment) {
        DefaultManager.shared.saveComment(object: comment)
    }
    
    func getComment() -> CommentModel.Comment? {
        return DefaultManager.shared.getComment()
    }
    
}
