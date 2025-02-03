//
//  RegView.swift
//  firebaseApp
//
//  Created by Chmil Oleksandr on 21.01.2025.
//

import UIKit

class RegView: UIViewController {
    private var viewBuilder = ViewBuilder()
    private let service = AuthService()
  
    lazy var titleLabel = viewBuilder.createLabel(frame: CGRect(x: 30, y: 100, width: view.frame.width - 60, height: 40), text: "Sign Up", size: 22)
    lazy var emailTextField = viewBuilder.createTextField(frame: CGRect(x: 30, y: titleLabel.frame.maxY + 60, width: view.frame.width - 60, height: 50), placeholder: "Email")
    lazy var passwordTextField = viewBuilder.createTextField(frame: CGRect(x: 30, y: emailTextField.frame.maxY + 20, width: view.frame.width - 60, height: 50), placeholder: "Password", isPassword: true)
    lazy var nameTextField = viewBuilder.createTextField(frame: CGRect(x: 30, y: passwordTextField.frame.maxY + 20, width: view.frame.width - 60, height: 50), placeholder: "Name")
    
    lazy var regAction: UIAction = UIAction{ [weak self] _ in
        guard let self = self else { return }
        
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        
        let user = UserData(email: email ?? "", password: password ?? "", name: name)
        service.createNewUser(user: user) { result in
            switch result {
            case .success(let success):
                NotificationCenter.default.post(name: Notification.Name(rawValue: "routeVC"), object: nil, userInfo: ["vc" : WindowCase.login])
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    lazy var loginAction: UIAction = UIAction{ _ in
        NotificationCenter.default.post(name: Notification.Name(rawValue: "routeVC"), object: nil, userInfo: ["vc" : WindowCase.login])
    }
    
    lazy var regBtn = viewBuilder.createButton(frame: CGRect(x: 30, y: view.frame.height - 150, width: view.frame.width - 60, height: 50), action: regAction, title: "Sign up", isMainBtn: true)
    lazy var logBtn = viewBuilder.createButton(frame: CGRect(x: 30, y: regBtn.frame.maxY + 10, width: view.frame.width - 60, height: 50), action: loginAction, title: "Already have an account?")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nameTextField)
        view.addSubview(regBtn)
        view.addSubview(logBtn)

    }
}
