//
//  UIViewControllerExtension.swift
//  FindCity
//
//  Created by Jafar on 15/02/2022.
//

import UIKit

protocol Navigatable {
}

extension UIViewController: Navigatable { }

extension Navigatable where Self: UIViewController {
    static func getViewController(storyboard:UIStoryboard.Storyboard = .main, identifier:String? = Self.identifier) -> Self {
        let identifierBind = (identifier != nil ? identifier : Self.identifier) ?? Self.identifier
        guard let viewController = UIStoryboard(storyboard: storyboard).instantiateViewController(withIdentifier: identifierBind) as? Self else {
            fatalError("Couldn't instantiate view controller with identifier \(Self.identifier) ")
        }
        return viewController
    }
}


extension UIStoryboard {
    enum Storyboard: String {
        case main
        
        var name: String {
            return rawValue.capitalizingFirstLetter()
        }
    }
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.name, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.name, bundle: bundle)
    }
}


extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}


extension  UIViewController {

    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alert.addAction(ok)
        onMain { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
