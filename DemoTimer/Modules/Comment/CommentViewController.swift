//
//  CommentViewController.swift
//  DemoTimer
//
//  Created by Hector Climaco on 20/07/23.
//  
//

import UIKit

protocol CommentDisplayLogic {
    func displayComment(comment: CommentModel.Comment)
}

class CommentViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var photoUserImageView: UIImageView!
    
    @IBOutlet weak var nameUserTextField: UITextField!
    @IBOutlet weak var lastNameUserTextField: UITextField!
    
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var commentTextView: UITextView!
    
    // MARK: - Variables
    
    var interactor: CommentBusinessLogic?
    var router: CommentRoutingLogic?
    var imagePicker: UIImagePickerController?
    
    var comment = CommentModel.Comment() {
        didSet {
            loadComment()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor?.getComment()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let userImage = self.photoUserImageView.image ?? UIImage()
        let name = self.nameUserTextField.text ?? ""
        let lastName = self.lastNameUserTextField.text ?? ""
        let commetUser = self.commentTextView.text ?? ""
        
        interactor?.saveData(comment: CommentModel.Comment(image: userImage, firstName: name, lastName: lastName, comment: commetUser))
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = CommentInteractor()
        let presenter       = CommentPresenter()
        let router          = CommentRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    // MARK: - Private
    func configureView() {
        self.title = "Comentarios"
            self.view.backgroundColor = Coulors.background
            photoUserImageView.apply(styles: .cornerMid)
            photoUserImageView.isUserInteractionEnabled = true
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnPhoto))
            photoUserImageView.addGestureRecognizer(tapGesture)
            
            commentView.apply(styles: .corner(10))
            commentView.backgroundColor = Coulors.textSelection
            commentTextView.textColor = Coulors.textButton
            commentTextView.backgroundColor = Coulors.textSelection
    }
    
    private func loadComment() {
        self.photoUserImageView.image = comment.getImage()
        self.photoUserImageView.contentMode = .scaleAspectFill
        self.nameUserTextField.text = comment.firstName
        self.lastNameUserTextField.text = comment.lastName
        self.commentTextView.text = comment.comment
    }
    
    // MARK: - Actions
    @objc func tapOnPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            self.imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
            imagePicker?.sourceType = .photoLibrary
            imagePicker?.allowsEditing = false
            photoUserImageView.image = Images.photoEmpty
            photoUserImageView.contentMode = .scaleAspectFill
            present(imagePicker!, animated: true, completion: nil)
        }
    }
    
}

extension CommentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoUserImageView.image = image
        }
        
    }
}

extension CommentViewController: CommentDisplayLogic {
    func displayComment(comment: CommentModel.Comment) {
        self.comment = comment
    }
    
    
}
