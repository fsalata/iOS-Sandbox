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
    func backToStart(_ viewModel: FlowViewModel)
}

final class FlowViewModel {
    var service: FlowService
    
    weak var delegate: FlowViewModelDelegate?
    
    init(service: FlowService = FlowService()) {
        self.service = service
    }
    
    func fetchData(completion: @escaping (Result<Void, Error>) -> ()) {
        service.fetchDate(completion: completion)
    }
    
    func showSecondVC() {
        delegate?.showSecondVC(self)
    }
    
    func showThirdVC() {
        delegate?.showThirdVC(self)
    }
    
    func backToStart() {
        delegate?.backToStart(self)
    }
}
