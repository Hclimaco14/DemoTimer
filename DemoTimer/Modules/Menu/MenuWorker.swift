//
//  MenuWorker.swift
//  DemoTimer
//
//  Created by Hector Climaco on 13/07/23.
//  
//

import UIKit

class MenuWorker {
    
    func getOptions() -> [MenuModel.MenuOption]{
        let options = [MenuModel.MenuOption(name: "Configuraciones", icon: Images.configureIcon),
                    MenuModel.MenuOption(name: "Commentarios", icon: Images.commentICon)]
        return options
    }
    
}
