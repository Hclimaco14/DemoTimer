//
//  OptionMenuCell.swift
//  DemoTimer
//
//  Created by Hector Climaco on 13/07/23.
//

import UIKit

class OptionMenuCell: UITableViewCell {
    
    public static let identifier = "OptionMenuCell"
    
    @IBOutlet weak var iconOptionImageView: UIImageView!
    @IBOutlet weak var optionTitleLabel: UILabel!
    
    var option = MenuModel.MenuOption() {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        self.selectionStyle = .none
        self.backgroundColor = Coulors.backgroundCell
        self.optionTitleLabel.textColor = Coulors.textButton
        iconOptionImageView.image = option.icon
        optionTitleLabel.text = option.name
    }
    
}
