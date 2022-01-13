//
//  GFItemInfoVC.swift
//  GitHub Followers
//
//  Created by Eslam Nahel on 13/01/2022.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    let stackView           = UIStackView()
    let itemInfoViewOne     = GFItemInfoView()
    let itemInfoViewTwo     = GFItemInfoView()
    let actionButton        = GFButton()
    
    let constraintsPadding: CGFloat = 20
    
    var user: User!
    weak var delegate: UserInfoVCDelegate?
    
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackground()
        addStackView()
        addActionButton()
    }
    
    
    @objc func didTapOnActionButton() {}
    
    
    private func configureBackground() {
        view.layer.cornerRadius = 18
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .secondarySystemBackground
    }
    
    
    private func addStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: constraintsPadding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraintsPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraintsPadding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        configureStackView()
    }
    
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    
    private func addActionButton() {
        view.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(didTapOnActionButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constraintsPadding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constraintsPadding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constraintsPadding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
