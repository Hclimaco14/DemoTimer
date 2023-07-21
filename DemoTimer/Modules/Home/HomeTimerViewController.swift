//
//  HomeTimerViewController.swift
//  DemoTimer
//
//  Created by Hector Climaco on 07/07/23.
//  
//

import SideMenu
import UIKit
import CoreHaptics
import AVFAudio

protocol HomeTimerDisplayLogic {
    func displayUserPreference(preference: ConfigureModel.UserPreference)
}

class HomeTimerViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var pickerHour: UIPickerView!
    @IBOutlet weak var labelHour: UILabel!
    
    @IBOutlet weak var acceptOrPauseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    // MARK: - Variables
    
    var interactor: HomeTimerBusinessLogic?
    var router: HomeTimerRoutingLogic?
    var currentTime = HomeTimer.Time()
    var pickerTime = HomeTimer.Time()
    var timer: Timer?
    var userPreference = ConfigureModel.UserPreference()
    
    var engine: CHHapticEngine?
    var soundEffect: AVAudioPlayer?
    
    var isTimerActive: Bool = false {
        didSet {
            let textButton = isTimerActive ? "Pausa" : "Reanudar"
            self.acceptOrPauseButton.setTitle(textButton, for: .normal)
        }
    }
    var isFaceUp:Bool {
        return UIDevice.current.orientation == .faceUp
    }
    
    var menu:SideMenuNavigationController?
    
    let menuButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
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
        interactor?.loadInitialConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.getUserPreference()
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = HomeTimerInteractor()
        let presenter       = HomeTimerPresenter()
        let router          = HomeTimerRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    fileprivate func configureView(){
        self.title = "Timer"
        self.view.backgroundColor = Coulors.background
        self.pickerHour.dataSource = self
        self.pickerHour.delegate = self
        self.labelHour.isHidden = true
        self.labelHour.attributedText = currentTime.toAttributedString()
        
        self.acceptOrPauseButton.apply(styles: .YellowButton)
        self.cancelButton.apply(styles: .RedButton)
        self.setRightButtons(rightButton: menuButton, rightAction: #selector(menuAction), rightIcon: "iconMenu")
        
        menu = SideMenuNavigationController(rootViewController: MenuViewController())
        menu?.leftSide = false
    }
    
    // MARK: - Private
    
    private func configureHaptics() {
        self.soundEffect?.stop()
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }

    private func timeMinusSecond(time: HomeTimer.Time) ->  HomeTimer.Time {

        var timeMinus = time
        
        if timeMinus.sec > 0{
            timeMinus.sec -= 1
        } else if timeMinus.min > 0 || timeMinus.hour > 0 {
            timeMinus.sec = 59
        }
        
        if timeMinus.min > 0 && timeMinus.sec == 59 {
            timeMinus.min -= 1
        } else if timeMinus.hour > 0 && timeMinus.min == 0 && timeMinus.sec == 59 {
            timeMinus.min = 59
        }
        
        if timeMinus.hour > 0 && timeMinus.min == 59 && timeMinus.sec == 59{
            timeMinus.hour -= 1
        }
        
        return timeMinus
    }

    private func resetTimer() {
        pickerHour.isHidden = false
        labelHour.isHidden = true
        isTimerActive = false
        currentTime = pickerTime
        labelHour.attributedText = currentTime.toAttributedString()
        acceptOrPauseButton.setTitle("Aceptar", for: .normal)
        timer?.invalidate()
        configureHaptics()
    }
    
    private func actionConfiguration() {
        let alertMenu = UIAlertController(title: "Configuracion", message: "Configure sus preferencias de Vibracion y Sonido para continuar", preferredStyle: .actionSheet)
        let configurationAction = UIAlertAction(title: "Configuraciones", style: .default) {_ in
            self.router?.goToConfiguration()
        }
        
        let commetAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertMenu.addAction(configurationAction)
        alertMenu.addAction(commetAction)
        
        alertMenu.popoverPresentationController?.sourceView = self.view
        let xOrigin = self.view.bounds.width / 2
        let popoverRect = CGRect(x: xOrigin, y: 0, width: 1, height: 1)
        alertMenu.popoverPresentationController?.sourceRect = popoverRect
        alertMenu.popoverPresentationController?.permittedArrowDirections = .up

        
        self.present(alertMenu, animated: true)
    }
    
    private func showAlecrtFaceUp() {
        let alertFaceUp = UIAlertController(title: "Configuracion", message: "El telefono tiene que estar sobre una superficie plana para iniciar", preferredStyle: .alert)
        let aceptAction = UIAlertAction(title: "Aceptar", style: .default)
        
        alertFaceUp.addAction(aceptAction)
        
        self.present(alertFaceUp, animated: true)
    }
    
    private func feedback(_ vibration: Vibration) {
        DispatchQueue.main.async {
            vibration.vibrate(engine: self.engine)
        }
    }
    
    private func feedback(_ sound: Sound) {
        DispatchQueue.main.async {
            sound.soundPlay(soundEffect: &self.soundEffect)
        }
        
    }
    
    private func timeOver() {
        switch userPreference.mode.mode {
    
        case .soundAndVibration:
            feedback(userPreference.sound.action)
            feedback(userPreference.vibration.action)
        case .onlySound:
            feedback(userPreference.sound.action)
        case .onlyVibration:
            feedback(userPreference.vibration.action)
        default:
            break
        
        }
        timer?.invalidate()
        resetTimer()
    }
    
    // MARK: - Actions
    
    @IBAction func acceptPauseAction(_ sender: Any) {
        if userPreference.mode.mode == .undefined {
            actionConfiguration()
            return
        } else if currentTime.isTimeOver {
            return
        }
        if !isFaceUp {
            showAlecrtFaceUp()
            return
        }
        
        pickerHour.isHidden = true
        labelHour.isHidden = false
        if isTimerActive {
            timer?.invalidate()
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        }
        isTimerActive = !isTimerActive
    }
    
    @IBAction func cancelAction(_ sender: Any) {
       resetTimer()
        self.engine?.stop()
        self.soundEffect?.stop()
    }
    
    @objc func timerAction() {
        if currentTime.isTimeOver {
            timeOver()
        }
        self.currentTime = timeMinusSecond(time: currentTime)
        
        labelHour.attributedText = currentTime.toAttributedString()
    }
    
    @objc func menuAction() {
        present(menu!, animated: true)
    }
}

extension HomeTimerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 24
        case 1:
            return 60
        case 2:
            return 60
        default:
            return 60
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        switch component {
        case 0:
            return row.formatTextHour(to: .hour)
        case 1:
            return row.formatTextHour(to: .min)
        case 2:
            return row.formatTextHour(to: .sec)
        default:
            return row.formatTextHour(to: .sec)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            pickerTime.hour = row
        case 1:
            pickerTime.min = row
        case 2:
            pickerTime.sec = row
        default:
            break

        }
        currentTime = pickerTime
        labelHour.attributedText = currentTime.toAttributedString()
    }
    
}

extension HomeTimerViewController: HomeTimerDisplayLogic {
    func displayUserPreference(preference: ConfigureModel.UserPreference) {
        self.userPreference = preference
    }
}
