//
//  UIViewController+Ext.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 02/11/2021.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, actionTitle: String) {
        DispatchQueue.main.async {
            let alertVC                     = GFAlertVC(title: title, message: message, buttonTitle: actionTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC                        = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor  = .systemGreen
        present(safariVC, animated: true)
    }
}
