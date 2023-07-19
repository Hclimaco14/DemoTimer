//
//  SoundAndVibrationCell.swift
//  DemoTimer
//
//  Created by Hector Climaco on 11/07/23.
//

import UIKit

class SoundAndVibrationCell: UITableViewCell {
    
    static let identifier = "SoundAndVibrationCell"
    
    
    //Outlets
        @IBOutlet weak var iconCell: UIImageView!
        @IBOutlet weak var valueSelectedLbl: UILabel!
        @IBOutlet weak var keySelectionLbl: UILabel!
        
        var selection =  ConfigureModel.Configuration() {
            didSet{
                configureCell()
            }
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.selectionStyle = .none
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
        
        func configureCell() {
            self.backgroundColor = Coulors.backgroundCell
            self.iconCell.image = Images.arrow
            self.keySelectionLbl.text = selection.name
            self.keySelectionLbl.textColor = Coulors.textButton
            self.valueSelectedLbl.text = selection.selection
            self.valueSelectedLbl.textColor = Coulors.textSelection
        }

    
}
