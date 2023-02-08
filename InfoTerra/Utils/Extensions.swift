//
//  Extensions.swift
//  InfoTerra
//
//  Created by John Padilla on 2/7/23.
//

import UIKit
//import JGProgressHUD

extension UIViewController {
    
//    func activityIndicator() {
//        let hud = JGProgressHUD(style: .dark)
//        
//        hud.textLabel.text = "All fields are required!"
//        hud.indicatorView = JGProgressHUDErrorIndicatorView()
//        hud.show(in: view)
//        hud.dismiss(afterDelay: 2.0)
//    }
}


extension UIColor {
    
    static var doTERRAPurpleColor = UIColor.init(red: 189/255, green: 138/255, blue: 199/255, alpha: 1)
    
    static var doTERRABackgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    
    static var doTERRADarkTextColor = UIColor.init(red: 50/255, green: 71/255, blue: 85/255, alpha: 1)
    
    static var doTERRABlueTextColor = UIColor.init(red: 0/255, green: 105/255, blue: 215/255, alpha: 1)
    
    static var deleteBackgroundColor = UIColor.init(red: 231/255, green: 76/255, blue: 60/255, alpha: 1)
    
    static var shareBackgroundColor = UIColor.init(red: 254/255, green: 149/255, blue: 38/255, alpha: 1)
    
    static var backgroundCategoryTag = UIColor.init(red: 241/255, green: 249/255, blue: 253/255, alpha: 1)


}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func fillSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let view = superview else { return }
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 18, paddingBottom: 10, paddingRight: 18)
    }
    
    func convertToCurrency(_ number: Double) -> String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        
        return currencyFormatter.string(from: NSNumber(value: number))!
    }
}

extension UINavigationItem {

  func setTitle(_ title: String, subtitle: String) {

    let titleLabel = UILabel()
    titleLabel.text = title
    titleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.headline)
      titleLabel.textColor = .doTERRABlueTextColor

    let subtitleLabel = UILabel()
    subtitleLabel.text = subtitle
    subtitleLabel.font = .preferredFont(forTextStyle: UIFont.TextStyle.subheadline)
      subtitleLabel.textColor = .doTERRADarkTextColor.withAlphaComponent(0.75)

    let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    stackView.distribution = .equalCentering
    stackView.alignment = .center
    stackView.axis = .vertical

    self.titleView = stackView
  }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UILabel {
    
//    func configureLabel(title: String, details: String) {
//
//        var attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title): ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.doTERRADarkTextColor]))
//        attributedText.append(NSAttributedString(string: "\(details)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.doTERRADarkTextColor]))
//        self.attributedText = attributedText
//
//    }
    
    func configureSearchLabel(title: String, details: String) {
        
        var attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: "\(title) ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.doTERRADarkTextColor]))
        attributedText.append(NSAttributedString(string: "\(details)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .light), NSAttributedString.Key.foregroundColor: UIColor.doTERRADarkTextColor]))
        self.attributedText = attributedText
        
    }
}
