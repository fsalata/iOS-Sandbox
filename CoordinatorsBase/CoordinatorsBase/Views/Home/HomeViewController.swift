//
//  HomeViewController.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel?
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        view.backgroundColor = .white

        let pushButton = UIButton()
        pushButton.setTitle("Push Flow", for: .normal)
        pushButton.addTarget(self, action: #selector(pushFlow), for: .touchUpInside)
        pushButton.setTitleColor(.black, for: .normal)
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pushButton)
        
        pushButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pushButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let presentButton = UIButton()
        presentButton.setTitle("Present Flow", for: .normal)
        presentButton.addTarget(self, action: #selector(presentFlow), for: .touchUpInside)
        presentButton.setTitleColor(.black, for: .normal)
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presentButton)
        
        presentButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        presentButton.topAnchor.constraint(equalTo: pushButton.bottomAnchor, constant: 16).isActive = true
    }
    
    @objc func pushFlow() {
        viewModel?.startFlow(isModal: false)
    }
    
    @objc func presentFlow() {
        viewModel?.startFlow(isModal: true)
    }
}
