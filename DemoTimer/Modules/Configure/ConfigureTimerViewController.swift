//
//  ConfigureTimerViewController.swift
//  DemoTimer
//
//  Created by Hector Climaco on 09/07/23.
//  
//

import UIKit

protocol ConfigureTimerDisplayLogic {
    func displayEnableModes(modes: [ConfigureModel.EnableMode])
    func displayConfigurations(configurations: [ConfigureModel.Configuration])
}

protocol changeModeDelegate {
    func changeMode(mode: ConfigureModel.EnableMode)
}

class ConfigureTimerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var modeTitleLabel: UILabel!
    
    @IBOutlet weak var enableModesTableView: UITableView!
    
    @IBOutlet weak var soundAndVibrationConfigLabel: UILabel!
    @IBOutlet weak var configurationsTableView: UITableView!
    
    // MARK: - Variables
    
    var interactor: ConfigureTimerBusinessLogic?
    var router: ConfigureTimerRoutingLogic?
    
    var enableModes:[ConfigureModel.EnableMode] = [] {
        didSet {
            DispatchQueue.main.async {
                self.enableModesTableView.reloadData()
            }
        }
    }
    
    var configurations:[ConfigureModel.Configuration] = [] {
        didSet{
            DispatchQueue.main.async {
                self.configurationsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Object Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        interactor?.loadModes()
        interactor?.loadConfigurations()
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = ConfigureTimerInteractor()
        let presenter       = ConfigureTimerPresenter()
        let router          = ConfigureTimerRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    
    func configureView() {
        self.view.backgroundColor = Coulors.background
        
        self.enableModesTableView.register(UINib(nibName: EnableModeCell.identifier, bundle: nil), forCellReuseIdentifier: EnableModeCell.identifier)
        self.enableModesTableView.isScrollEnabled = false
        self.enableModesTableView.backgroundColor = Coulors.background
        self.enableModesTableView.apply(styles: .corner(10))
        self.enableModesTableView.dataSource = self
        self.enableModesTableView.delegate = self

        
        self.configurationsTableView.register(UINib(nibName: SoundAndVibrationCell.identifier, bundle: nil), forCellReuseIdentifier: SoundAndVibrationCell.identifier)
        self.configurationsTableView.isScrollEnabled = false
        self.configurationsTableView.backgroundColor = Coulors.background
        self.configurationsTableView.apply(styles: .corner(10))
        self.configurationsTableView.dataSource = self
        self.configurationsTableView.delegate = self
        
        self.modeTitleLabel.textColor = Coulors.textButton
        
        self.soundAndVibrationConfigLabel.textColor = Coulors.textButton
        
    }
    
    
}

extension ConfigureTimerViewController: changeModeDelegate {
    func changeMode(mode: ConfigureModel.EnableMode) {
        if let firtIndex = enableModes.firstIndex(where: { $0.id == mode.id }), mode.id != 1{
            self.enableModes[firtIndex] = mode
            if let indexAll = enableModes.firstIndex(where: {$0.id == 1}) {
                self.enableModes[indexAll].isOn = false
            }
        } else {
            for index in 0..<enableModes.count {
                self.enableModes[index].isOn = mode.isOn
            }
        }
    }
    
}

extension ConfigureTimerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.configurationsTableView {
            return configurations.count
        } else if tableView == self.enableModesTableView {
            return enableModes.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.configurationsTableView,
            let cell = tableView.dequeueReusableCell(withIdentifier: SoundAndVibrationCell.identifier, for: indexPath) as? SoundAndVibrationCell {
            cell.selection =  configurations[indexPath.row]
            return cell
            
        } else if tableView == self.enableModesTableView, let cellMode = tableView.dequeueReusableCell(withIdentifier: EnableModeCell.identifier, for: indexPath) as? EnableModeCell {
            cellMode.enableMode = enableModes[indexPath.row]
            cellMode.delegate = self
            return cellMode
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == configurationsTableView {
            router?.goToActionList(configuration: configurations[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (SpaceUnits.one * 6)
    }
    
}

extension ConfigureTimerViewController: ConfigureTimerDisplayLogic {
    func displayConfigurations(configurations: [ConfigureModel.Configuration]) {
        self.configurations = configurations
    }
    
    func displayEnableModes(modes: [ConfigureModel.EnableMode]) {
        self.enableModes = modes
    }
}
