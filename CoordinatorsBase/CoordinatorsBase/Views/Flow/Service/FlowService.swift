//
//  FlowService.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import Foundation

final class FlowService {
    func fetchDate(completion: @escaping (Result<Void, Error>) -> ()) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3) {
            completion(.success(()))
        }
    }
}
