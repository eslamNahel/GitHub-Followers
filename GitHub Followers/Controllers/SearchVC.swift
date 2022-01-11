//
//  SearchVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 01/11/2021.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK: - Components
    let logoImageView       = UIImageView()
    let userNameTextField   = GFTextField()
    let CTAButton           = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUserNameEntered: Bool { return !userNameTextField.text!.isEmpty}
    var buttonConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLogoImageView()
        configureUserNameTextField()
        configureCTAButton()
        createDismissKeyboardGesture()
        addNotificationCenterToKeyboard()
        
        self.view.layoutIfNeeded()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.userNameTextField.becomeFirstResponder()
        }
    }
    
    
    //MARK: - Additional Methods
    
    private func createDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc private func pushFollowersVC() {
        guard isUserNameEntered else {
            presentAlertOnMainThread(title: "No user name Entered", message: "Please enter a user name so we can get followers 😃", actionTitle: "Ok")
            return
        }
        
        let followersVC         = FollowersListVC()
        followersVC.userName    = userNameTextField.text
        followersVC.title       = userNameTextField.text
        
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    
    private func addNotificationCenterToKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            self.buttonConstraint.constant = -50
            self.view.layoutIfNeeded()
        } else {
            self.buttonConstraint.constant = -keyboardViewEndFrame.height + 75
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK: - Configure UI Methods
    
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureUserNameTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    
    private func configureCTAButton() {
        view.addSubview(CTAButton)
        CTAButton.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            CTAButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            CTAButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            CTAButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        buttonConstraint = CTAButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        buttonConstraint.isActive = true
    }
}


//MARK: - Extensions

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersVC()
        createDismissKeyboardGesture()
        return true
    }
}
