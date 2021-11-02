//
//  UIViewController+Ext.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 02/11/2021.
//

import UIKit

extension UIViewController {
    func presentAlertOnMainThread(title: String, message: String, actionTitle: String) {
        let alertVC = GFAlertVC(title: title, message: message, buttonTitle: actionTitle)
        alertVC.modalPresentationStyle  = .overFullScreen
        alertVC.modalTransitionStyle    = .crossDissolve
        present(alertVC, animated: true)
    }
}
