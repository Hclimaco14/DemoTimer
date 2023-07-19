//
//  Style.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//

import UIKit

public struct StyleView {
    let applyTo: (UIView) -> Void
    
    static var cornerMid: StyleView {
        return StyleView { view in
            view.layer.cornerRadius = (view.frame.height / 2)
            view.clipsToBounds = true
        }
    }
    
    static func corner(_ cornerRadius: CGFloat) -> StyleView {
        return StyleView { view in
            view.layer.cornerRadius = cornerRadius
            view.clipsToBounds = true
        }
    }
    
    static func color(_ color: UIColor) -> StyleView {
      return StyleView { view in
        view.backgroundColor = color
      }
    }
}

public struct StyleButton {
    let applyTo: (UIButton) -> Void
    
    static var YellowButton:StyleButton{
      return StyleButton { button in
          button.apply(styles: .cornerMid,.color(Coulors.primaryButton))
          button.tintColor = Coulors.textButton
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
      }
    }
    
    static var RedButton:StyleButton{
      return StyleButton { button in
          button.apply(styles: .cornerMid,.color(Coulors.secondaryButton))
          button.tintColor = Coulors.textButton
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
          
      }
    }
}

