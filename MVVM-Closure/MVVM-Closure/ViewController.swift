//
//  ViewController.swift
//  MVVM-Closure
//
//  Created by Fábio Salata on 05/10/20.
//  Copyright © 2020 Fábio Salata. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var increaseButton: UIButton!
    
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updater = { [unowned self] value in
            self.counterLabel.text = "\(value)"
        }
    }

    @IBAction func increaseValue(_ sender: Any) {
        viewModel.increaseValue()
    }
}

