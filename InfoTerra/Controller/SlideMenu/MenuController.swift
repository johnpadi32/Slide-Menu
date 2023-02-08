//
//  MenuController.swift
//  InfoTerra
//
//  Created by John Padilla on 2/7/23.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuController.MenuOptions)
}

class MenuController: UIViewController {
    
    enum MenuOptions: String, CaseIterable {
        case Home = "Home"
        case info = "Information"
        case appRating = "App Rating"
        case shareApp = "Share App"
        case setting = "Settings"
        
        var imageName: String {
            switch self {
            case .Home:
                return "house"
            case .info:
                return "airplane"
            case .appRating:
                return "star"
            case .shareApp:
                return "message"
            case .setting:
                return "gear"
            }
        }
    }
    
    //MARK: - Properties
    
    weak var delegate: MenuViewControllerDelegate?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = nil
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundCategoryTag
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Menu"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.width, height: view.bounds.size.height)
    }
    
    //MARK: - Helpers
    
    //MARK: - Actions
}


extension MenuController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .gray
        cell.backgroundColor = nil
        cell.contentView.backgroundColor = nil
        return cell
    }  
}

extension MenuController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
