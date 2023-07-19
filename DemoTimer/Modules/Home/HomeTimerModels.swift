//
//  HomeTimerModels.swift
//  DemoTimer
//
//  Created by Hector Climaco on 07/07/23.
//  
//

import UIKit

enum HomeTimer {

    struct Time {
        var hour:Int
        var min:Int
        var sec:Int
        
        var isTimeOver:Bool {
            return hour == 0 && min == 0 && sec == 0
        }
        
        init(){
            self.hour = 0
            self.min = 0
            self.sec = 0
        }
        
        func toAttributedString() -> NSAttributedString {
            
            let size:CGFloat = hour > 0 ? 30 : 35
            let attributesOne: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemOrange,
                                                                .font: UIFont.boldSystemFont(ofSize: size)]
            let secString = String(format: "%02d", sec)
            let minString = String(format: "%02d", min) + ":"
            let hourString = hour > 0 ? String(format: "%02d", hour) + ":" : ""
            
            let time = NSMutableAttributedString(string: hourString,attributes: attributesOne)
            time.append(NSAttributedString(string: minString,attributes: attributesOne))
            time.append(NSAttributedString(string: secString,attributes: attributesOne))
            
            return time
            
        }
        
        
    }
    
    enum TimeTypes: String{
        case hour = "horas"
        case min = "min"
        case sec = "s"
        
    
    }
    
}
