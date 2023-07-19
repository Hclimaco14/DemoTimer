//
//  CommentsViewController.swift
//  DemoTimer
//
//  Created by Hector Climaco on 11/07/23.
//  
//

import UIKit

protocol CommentsDisplayLogic {
    func displaySomething(viewModel: Comments.Something.ViewModel)
}

class CommentsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var photoUserImageView: UIImageView!
    @IBOutlet weak var photoUserLabel: UILabel!
    
    @IBOutlet weak var nameUserLabel: UITextField!
    @IBOutlet weak var lastNameUserLabel: UITextField!
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    
    // MARK: - Variables
    
    var interactor: CommentsBusinessLogic?
    var router: CommentsRoutingLogic?
    
    var imagePicker = UIImagePickerController()
    
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
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = CommentsInteractor()
        let presenter       = CommentsPresenter()
        let router          = CommentsRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    // MARK: - Private
    func configureView() {
        self.view.backgroundColor = Coulors.background
        photoUserImageView.apply(styles: .cornerMid)
        photoUserImageView.image = Images.photoEmpty
        photoUserImageView.contentMode = .scaleAspectFill
        photoUserImageView.isUserInteractionEnabled = true
        photoUserLabel.text = "Selecciona una foto"
        photoUserLabel.textColor = Coulors.textButton
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnPhoto))
        photoUserImageView.addGestureRecognizer(tapGesture)
        
        commentView.apply(styles: .corner(10))
        commentTextView.textColor = Coulors.textButton
        commentLabel.text = "Notas"
        commentLabel.textColor = Coulors.textButton
    }
    
    // MARK: - Actions
    
    @objc func tapOnPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
}

extension CommentsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoUserImageView.image = image
        }

    }
}

extension CommentsViewController: CommentsDisplayLogic {
    func displaySomething(viewModel: Comments.Something.ViewModel) {}
}
