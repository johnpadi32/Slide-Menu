//
//  ViewController.swift
//  InfoTerra
//
//  Created by John Padilla on 2/7/23.
//

import UIKit


protocol HomeViewControllerDelegate: AnyObject {
    func didTapMenuButton()
}

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: HomeViewControllerDelegate?
    

    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        


    }
    
    //MARK: - Helpers
    
    private func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal"), style: .plain, target: self, action: #selector(showMenuController))
        title = "Working"
    }
    
    //MARK: - Actions
    
    @objc func showMenuController() {
        delegate?.didTapMenuButton()
    }
}

