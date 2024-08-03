//
//  ViewControllerExtension.swift
//  TunaSort iOS
//
//  Created by MAGH on 15/07/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentAlertController(title: String, message: String, buttonTitle: String, completion: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: completion)
            controller.addAction(action)
            action.setValue(UIColor(named: "TS_green"), forKey: "titleTextColor")
            self.present(controller, animated: true)
        }
    }
    
}
