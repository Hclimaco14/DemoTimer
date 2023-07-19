//
//  MenuViewController.swift
//  DemoTimer
//
//  Created by Hector Climaco on 13/07/23.
//  
//

import UIKit

protocol MenuDisplayLogic {
    func displayMenuOptions(_ options:[MenuModel.MenuOption])
}

class MenuViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var menuTableView: UITableView!
    
    // MARK: - Variables
    
    var interactor: MenuBusinessLogic?
    var router: MenuRoutingLogic?
    
    var options: [MenuModel.MenuOption] = [] {
        didSet {
            DispatchQueue.main.async {
                self.menuTableView.reloadData()
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
        interactor?.getMenuOptions()
    }
    
    // MARK: - Configurators
    
    fileprivate func setup() {
        
        let viewcontroller   = self
        let interactor      = MenuInteractor()
        let presenter       = MenuPresenter()
        let router          = MenuRouter()
        
        viewcontroller.interactor = interactor
        viewcontroller.router     = router
        interactor.presenter      = presenter
        presenter.view            = viewcontroller
        router.view               = viewcontroller
    }
    
    private func configureView() {
        self.view.backgroundColor = Coulors.background
        self.menuTableView.backgroundColor = Coulors.background
        self.menuTableView.register(UINib(nibName: OptionMenuCell.identifier, bundle: nil), forCellReuseIdentifier: OptionMenuCell.identifier)
        self.menuTableView.dataSource = self
        self.menuTableView.delegate = self
    }
    
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OptionMenuCell.identifier, for: indexPath) as? OptionMenuCell else {
            return UITableViewCell()
        }
        cell.option = options[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            router?.goToConfiguration()
        default:
            router?.goToComments()
        }
    }
    
}

extension MenuViewController: MenuDisplayLogic {
    func displayMenuOptions(_ options:[MenuModel.MenuOption]) {
        self.options = options
    }
}
