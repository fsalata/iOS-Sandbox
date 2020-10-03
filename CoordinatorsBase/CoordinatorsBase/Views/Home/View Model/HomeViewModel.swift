//
//  HomeViewModel.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func startFlow(_ viewModel: HomeViewModel, isModal: Bool)
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    
    func startFlow(isModal: Bool = false) {
        delegate?.startFlow(self, isModal: isModal)
    }
}
