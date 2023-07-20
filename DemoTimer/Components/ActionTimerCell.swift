//
//  ActionTimerCell.swift
//  DemoTimer
//
//  Created by Hector Climaco on 12/07/23.
//

import UIKit

class ActionTimerCell: UITableViewCell {
    
    static let identifier = "ActionTimerCell"
    
    @IBOutlet weak var checkImageView: UIImageView!
    
    @IBOutlet weak var actionNameLabel: UILabel!
    

    var action:ConfigurationAction = ConfigurationAction() {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        self.selectionStyle = .none
        self.checkImageView.image = action.isEnable ? Images.checkmark : UIImage()
        self.backgroundColor = Coulors.backgroundCell
        self.actionNameLabel.textColor = Coulors.textButton
        self.actionNameLabel.text = action.name
    }
    
}
