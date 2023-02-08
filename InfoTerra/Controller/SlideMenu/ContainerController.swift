//
//  ContainerController.swift
//  InfoTerra
//
//  Created by John Padilla on 2/7/23.
//

import UIKit

class ContainerController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    //MARK: - Properties
    
    private let homeController = HomeController()
    private let menuController = MenuController()
    var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()
    
    private var menuState: MenuState = .closed

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVcs()
    }
    
    //MARK: - Helpers
    
    func addChildVcs() {
        
        // Menu
        menuController.delegate = self
        addChild(menuController)
        view.addSubview(menuController.view)
        menuController.didMove(toParent: self)

        
        // Home
        homeController.delegate = self
        let navVC = UINavigationController(rootViewController: homeController)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC

    }

    
    func toggleMenu(completion: (() -> Void)?) {
        
        switch menuState.self {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeController.view.frame.size.width - 100
            } completion: { done in
                if done {
                    self.menuState = .opened

                }
            }

            
        case .opened:
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { done in
                if done {
                    self.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
    
    //MARK: - Actions
    

}

extension ContainerController: HomeViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
}

extension ContainerController: MenuViewControllerDelegate {
    
    func didSelect(menuItem: MenuController.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .Home:
            self.resetToHome()
        case .info:
            self.addInfo()
        case .appRating:
            break
        case .shareApp:
            break
        case .setting:
            break
        
        }
    }
    
    func addInfo() {
        let vc = infoVC
        
        homeController.addChild(vc)
        homeController.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeController)
        homeController.title = vc.title
    }
    
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeController.title = "Home"
    }
}
