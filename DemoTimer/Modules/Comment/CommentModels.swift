//
//  CommentModels.swift
//  DemoTimer
//
//  Created by Hector Climaco on 20/07/23.
//  
//

import UIKit

enum CommentModel {
    struct Comment:Codable {
        var dataImge    : Data
        var firstName   : String
        var lastName    : String
        var comment     : String
        
        init() {
            dataImge    = Data()
            firstName   = ""
            lastName    = ""
            comment     = ""
        }
        
        init(image: UIImage,firstName: String, lastName: String, comment: String) {
            self.firstName = firstName
            self.lastName = lastName
            self.dataImge = image.jpegData(compressionQuality: 0.5) ?? Data()
            self.comment = comment
        }
        
        mutating func setImage(image: UIImage) {
            if let data = image.jpegData(compressionQuality: 0.5) {
                self.dataImge = data
            }
        }
        
        func getImage() -> UIImage {
            return UIImage(data: self.dataImge) ?? UIImage()
        }
        
    }
}
