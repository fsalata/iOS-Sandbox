//
//  ViewController.swift
//  CombineUIKit
//
//  Created by Fábio Salata on 22/10/20.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @Published private var username: String = ""
    @Published private var password: String = ""
    @Published private var repeatPassword: String = ""
    
    var loginButtonCancellable: AnyCancellable?
    var userNameCancellable: AnyCancellable?
    var passwordCancellable: AnyCancellable?
    
    var validateUsername: AnyPublisher<String?, Never> {
        return $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .flatMap { username in
                return Future { promise in
                    self.isUsernameAvailable(username) { available in
                        promise(.success(available ? username : nil))
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    var validatePassword: AnyPublisher<String?, Never> {
        return $password.combineLatest($repeatPassword)
            .filter { !$0.0.isEmpty && !$0.1.isEmpty }
            .map { password, repeatPassword -> String? in
            guard password == repeatPassword, password.count > 4 else { return nil }
            return password
        }
        .map { $0 == "password" ? nil : $0 }
        .eraseToAnyPublisher()
    }
    
    var validateCredentials: AnyPublisher<(String, String)?, Never> {
        return validateUsername.combineLatest(validatePassword).map { username, password in
            guard let usr = username, let pwd = password else { return nil }
            return (usr, pwd)
        }
        .eraseToAnyPublisher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [usernameTextField, passwordTextField, repeatPasswordTextField].forEach { textfield in
            textfield?.layer.borderWidth = 0.3
            textfield?.layer.borderColor = UIColor.lightGray.cgColor
            textfield?.layer.cornerRadius = 5
        }
        
        userNameCancellable = validateUsername
            .map { $0 != nil ? true : false }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { isAvailable in
                self.usernameTextField.layer.borderWidth = isAvailable ? 0.3 : 0.6
                self.usernameTextField.layer.borderColor = isAvailable ? UIColor.lightGray.cgColor : UIColor.red.cgColor
            })
        
        passwordCancellable = validatePassword
            .map { $0 != nil ? true : false }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { isAvailable in
                self.passwordTextField.layer.borderWidth = isAvailable ? 0.3 : 0.6
                self.passwordTextField.layer.borderColor = isAvailable ? UIColor.lightGray.cgColor : UIColor.red.cgColor
                
                self.repeatPasswordTextField.layer.borderWidth = isAvailable ? 0.3 : 0.6
                self.repeatPasswordTextField.layer.borderColor = isAvailable ? UIColor.lightGray.cgColor : UIColor.red.cgColor
            })
        
        loginButtonCancellable = validateCredentials
            .map { $0 != nil }
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginButton)
    }
    
    @IBAction func usernameChanged(_ sender: UITextField) {
        username = sender.text ?? ""
    }
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        password = sender.text ?? ""
    }
    
    @IBAction func repeatPasswordChanged(_ sender: UITextField) {
        repeatPassword = sender.text ?? ""
    }
    
    private func isUsernameAvailable(_ username: String, completion: @escaping (_ available: Bool) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion(username == "bin" ? true : false)
        }
    }
}



