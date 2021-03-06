//
//  UIViewControllerExtension.swift
//  CloudKitJournal
//
//  Created by Chris Gottfredson on 3/30/20.
//  Copyright © 2020 Zebadiah Watson. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
    
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }
    
}
