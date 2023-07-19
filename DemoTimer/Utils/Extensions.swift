//
//  Extensions.swift
//  DemoTimer
//
//  Created by Hector Climaco on 08/07/23.
//

import Foundation
import UIKit

extension Int {
    
    func formatTextHour(to type: HomeTimer.TimeTypes ) -> NSAttributedString {
        let value = self
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white,
                                                        .font: UIFont.systemFont(ofSize: 25)]
        
        let attributesTwo: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemOrange
                                                            ]
        
        let hourStr = NSMutableAttributedString(string: "\(value)",attributes: attributes)
        let descriptionStr = NSAttributedString(string: " " + type.rawValue,attributes: attributesTwo)
        
        hourStr.append(descriptionStr)
        return hourStr
    }
}


extension UIView {
    func apply(styles: StyleView...) {
        styles.forEach { $0.applyTo(self) }
    }
}

extension UIButton {
  func apply(styles: StyleButton...) {
    styles.forEach{ $0.applyTo(self) }
  }
  
}

extension UIViewController {
    func setRightButtons( rightButton: UIButton, rightAction: Selector,rightIcon: String){
        let nav = self.navigationController?.navigationBar
        nav!.isTranslucent = false
        nav!.barTintColor = Coulors.background
        
        rightButton.addTarget(self, action: rightAction, for: UIControl.Event.touchUpInside)
        let rightBarButtonItem: UIBarButtonItem = getCustomRightBarButtonSettings(rightButton, imgNormal: UIImage(named:rightIcon)!)
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        if #available(iOS 15, *) {
            let font15 = UIFont.systemFont(ofSize: 15)
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowColor = .clear
            appearance.backgroundColor = Coulors.background
            appearance.titleTextAttributes = [ .font : font15, .foregroundColor : Coulors.textButton]
            nav?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            nav?.shadowImage = UIImage()
            nav?.scrollEdgeAppearance = appearance
            nav?.standardAppearance = appearance
        }
    }
}

func getCustomRightBarButtonSettings(_ button:UIButton, imgNormal:UIImage,needPading:Bool = true) -> UIBarButtonItem {
    button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    button.setImage(imgNormal, for: UIControl.State())
    if needPading {
        button.imageEdgeInsets.right   = -(SpaceUnits.two + SpaceUnits.half)
    } else {
        button.imageEdgeInsets.right   = -(SpaceUnits.four)
    }
    button.imageEdgeInsets.bottom = 10.0
    return UIBarButtonItem(customView: button)
}
