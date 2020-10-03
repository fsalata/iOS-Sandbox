//
//  FlowViewModel.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import Foundation

protocol FlowViewModelDelegate: AnyObject {
    func showSecondVC(_ viewModel: FlowViewModel)
    func showThirdVC(_ viewModel: FlowViewModel)
}

final class FlowViewModel {
    weak var delegate: FlowViewModelDelegate?
    
    func showSecondVC() {
        delegate?.showSecondVC(self)
    }
    
    func showThirdVC() {
        delegate?.showThirdVC(self)
    }
}
