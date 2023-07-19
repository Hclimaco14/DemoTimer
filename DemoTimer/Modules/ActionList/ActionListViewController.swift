//
//  ActionListViewController.swift
//  DemoTimer
//
//  Created by Hector Climaco on 12/07/23.
//  
//

import UIKit
import CoreHaptics
import AVFAudio

protocol ActionListDisplayLogic {
    func displaySomething(viewModel: ActionList.Something.ViewModel)
}

class ActionListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var actionListTableView: UITableView!
    
    @IBOutlet weak var tableViewHeightConstrain: NSLayoutConstraint!
    
    // MARK: - Variables
    
    var interactor: ActionListBusinessLogic?
    var router: ActionListRoutingLogic?
    var configureActions = ConfigureModel.Configuration()
    
    var engine: CHHapticEngine?
    var soundEffect: AVAudioPlayer?
    
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
        configureHaptics()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        soundEffect?.stop()
        engine?.stop()
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = ActionListInteractor()
        let presenter       = ActionListPresenter()
        let router          = ActionListRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    // MARK: - Private
    
    private func configureView() {
        self.view.backgroundColor = Coulors.background
        
        self.actionListTableView.register(UINib(nibName: ActionTimerCell.identifier, bundle: nil), forCellReuseIdentifier: ActionTimerCell.identifier)
        self.actionListTableView.isScrollEnabled = false
        self.actionListTableView.backgroundColor = Coulors.background
        self.actionListTableView.apply(styles: .corner(10))
        
        self.actionListTableView.dataSource = self
        self.actionListTableView.delegate = self
        self.title = configureActions.name
    }
    
    func configureHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - Actions
    
    func feedback(_ vibration: Vibration) {
        vibration.vibrate(engine: self.engine)
    }
    
    func feedback(_ sound: Sound) {
        sound.soundPlay(soundEffect: &self.soundEffect)
    }
    
}

extension ActionListViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configureActions.configurations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActionTimerCell.identifier, for: indexPath) as? ActionTimerCell else {
            return UITableViewCell()
        }
        cell.action = configureActions.configurations[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for index in 0..<configureActions.configurations.count {
            if index == indexPath.row {
                configureActions.configurations[index].isEnable = true
            } else  {
                configureActions.configurations[index].isEnable = false
            }
        }
        
        
        if let vibrationAction = configureActions.configurations[indexPath.row] as? ConfigureModel.VibracionAction {
            feedback(vibrationAction.action)
        } else if let soundAction = configureActions.configurations[indexPath.row] as? ConfigureModel.SoundAction {
            feedback(soundAction.action)
        }
        
        self.actionListTableView.reloadData()
       
    }
    
}

extension ActionListViewController: ActionListDisplayLogic {
    func displaySomething(viewModel: ActionList.Something.ViewModel) {}
}
