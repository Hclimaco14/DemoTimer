//
//  EnableModeCell.swift
//  DemoTimer
//
//  Created by Hector Climaco on 10/07/23.
//

import UIKit

class EnableModeCell: UITableViewCell {
    
    static let identifier = "EnableModeCell"
    
    //outlets
    @IBOutlet weak var titleModeLabel: UILabel!
    @IBOutlet weak var enableModeSwitch: UISwitch!
    
    //variables
    var enableModePhone = ConfigureModel.EnableMode() {
        didSet{
            configureCell()
        }
    }
    
    var delegate: changeModeDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell() {
        self.backgroundColor = Coulors.backgroundCell
        self.titleModeLabel.text = enableModePhone.name
        self.titleModeLabel.textColor = Coulors.textButton
        self.enableModeSwitch.isOn = enableModePhone.isOn
    }
    
    @IBAction func valueChange(_ sender: Any) {
        guard let value = sender as? UISwitch else {
             return
        }
        
        enableModePhone.isOn = value.isOn
        delegate?.changeMode(mode: enableModePhone)
    }
    
    
}
