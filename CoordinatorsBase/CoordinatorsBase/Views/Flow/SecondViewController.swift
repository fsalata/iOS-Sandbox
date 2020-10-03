//
//  SecondViewController.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import UIKit

class SecondViewController: UIViewController {
    var viewModel: FlowViewModel?
    
    init(viewModel: FlowViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        title = "Second VC"
        
        let button = UIButton()
        button.setTitle("Next VC", for: .normal)
        button.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func nextVC() {
        viewModel?.showThirdVC()
    }

}
