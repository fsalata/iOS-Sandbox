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
    
    var validateUsername: AnyPublisher<String?, Never> {
        return $username
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
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
        return Publishers.CombineLatest($password, $repeatPassword).map { password, repeatPassword -> String? in
            guard password == repeatPassword, password.count > 4 else { return nil }
            return password
        }
        .map { $0 == "password" ? nil : $0 }
        .eraseToAnyPublisher()
    }
    
    var validateCredentials: AnyPublisher<(String, String)?, Never> {
        return Publishers.CombineLatest(validateUsername, validatePassword).map { username, password in
            guard let usr = username, let pwd = password else { return nil }
            return (usr, pwd)
        }
        .eraseToAnyPublisher()
    }
    
    var loginButtonCancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButtonCancellable = self.validateCredentials
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
            completion(true)
        }
    }
}



