//
//  TemporaryViewModel.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import Foundation

protocol TemporaryViewModelDelegate: AnyObject {
    func startFlow(_ viewModel: TemporaryViewModel)
}

final class TemporaryViewModel {
    var service: FlowService
    
    weak var delegate: TemporaryViewModelDelegate?
    
    init(service: FlowService = FlowService()) {
        self.service = service
    }
    
    func fetchData(completion: @escaping (Result<Void, Error>) -> ()) {
        service.fetchDate(completion: completion)
    }
    
    func startFlow() {
        delegate?.startFlow(self)
    }
}
