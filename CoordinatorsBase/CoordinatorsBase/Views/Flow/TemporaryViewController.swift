//
//  TemporaryViewController.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import UIKit

class TemporaryViewController: UIViewController {
    var viewModel: TemporaryViewModel?
    var presentationType: FlowCoordinator.FlowType?

    let button = UIButton()
    
    init(viewModel: TemporaryViewModel, presentationType: FlowCoordinator.FlowType) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.presentationType = presentationType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Temporary VC"
        
        view.backgroundColor = .red
        
        button.isHidden = true
        button.setTitle("First VC", for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configureBackButton() {
        if case .modal = presentationType! {
            navigationItem.hidesBackButton = true
            
            let closeButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(closeFlow))
            
            navigationItem.leftBarButtonItem = closeButtonItem
        }
    }
    
    @objc func closeFlow() {
        self.navigationController?.dismiss(animated: true)
    }
    
    @objc func nextVC() {
        viewModel?.startFlow()
    }
}
