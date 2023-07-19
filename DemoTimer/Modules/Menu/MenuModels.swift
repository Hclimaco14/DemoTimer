//
//  MenuModels.swift
//  DemoTimer
//
//  Created by Hector Climaco on 13/07/23.
//  
//

import UIKit

enum MenuModel {
    struct MenuOption {
        var name: String
        var icon: UIImage
        
        init(name: String, icon: UIImage) {
            self.name = name
            self.icon = icon
        }
        init() {
            self.name = ""
            self.icon = UIImage()
        }
    }
}
