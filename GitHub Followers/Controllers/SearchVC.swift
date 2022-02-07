//
//  SearchVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 01/11/2021.
//

import UIKit

class SearchVC: UIViewController {
    
    //MARK: - Components & Properties
    let logoImageView       = UIImageView()
    let userNameTextField   = GFTextField()
    let CTAButton           = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUserNameEntered: Bool { return !userNameTextField.text!.isEmpty}
    var buttonConstraint: NSLayoutConstraint!
    var logoImageConstraint: NSLayoutConstraint!
    
    
    //MARK: - VC Lifecycle methods
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
        self.userNameTextField.text = ""
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
        
        userNameTextField.resignFirstResponder()
        
        let username     = userNameTextField.text!
        let followersVC  = FollowersListVC(username: username)
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
        
        let keyboardScreenEndFrame          = keyboardValue.cgRectValue
        let keyboardViewEndFrame            = view.convert(keyboardScreenEndFrame, from: view.window)
        let buttonBottomConstant: CGFloat   = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 30 : 50
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            self.buttonConstraint.constant = -50
        } else {
            self.buttonConstraint.constant = -keyboardViewEndFrame.height + buttonBottomConstant
        }
        self.view.layoutIfNeeded()
    }
    
    
    //MARK: - UI Configuration Methods
    private func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.image = AppImages.GHLogo
        
        let logoImageTopConstant: CGFloat       = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 60 : 80
        let logoImageWidthAndHeight: CGFloat    = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 180 : 200
        
        logoImageConstraint                     = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: logoImageTopConstant)
        logoImageConstraint.isActive            = true
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: logoImageWidthAndHeight),
            logoImageView.widthAnchor.constraint(equalToConstant: logoImageWidthAndHeight)
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
        return true
    }
}
