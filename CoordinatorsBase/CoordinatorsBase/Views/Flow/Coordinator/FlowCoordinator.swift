//
//  FlowCoordinator.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import UIKit

final class FlowCoordinator: BaseCoordinator {
    var view: UIViewController?
    var navigation: CustomNavigationController?
    var presentationType: PresentationType?
    
    var flowViewModel: FlowViewModel?
    var firstViewController: FirstViewController?
    var secondViewController: SecondViewController?
    var thirdViewController: ThirdViewController?
    
    func start() -> UIViewController {
        flowViewModel = FlowViewModel()
        flowViewModel?.delegate = self
        firstViewController = FirstViewController(viewModel: flowViewModel!)
        return firstViewController!
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
        firstViewController = nil
        secondViewController = nil
        thirdViewController = nil
    }
}

extension FlowCoordinator: FlowViewModelDelegate {
    func showSecondVC(_ viewModel: FlowViewModel) {
        secondViewController = SecondViewController(viewModel: viewModel)
        navigation?.pushViewController(secondViewController!, animated: true)
    }
    
    func showThirdVC(_ viewModel: FlowViewModel) {
        thirdViewController = ThirdViewController(viewModel: viewModel)
        navigation?.pushViewController(thirdViewController!, animated: true)
    }
    
}
