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
    
    var innerNavigation: CustomNavigationController?
    
    var flowViewModel: FlowViewModel?
    var firstViewController: FirstViewController?
    var secondViewController: SecondViewController?
    var thirdViewController: ThirdViewController?
    
    var temporaryViewController: TemporaryViewController?
    
    lazy var flowType: FlowType = {
        switch presentationType {
        case .modal(_):
            return .modal
        default:
            return .push
        }
    }()
    
    func start() -> UIViewController {
        flowViewModel = FlowViewModel()
        flowViewModel?.delegate = self
        firstViewController = FirstViewController(viewModel: flowViewModel!, presentationType: flowType)
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
    
    func backToStart(_ viewModel: FlowViewModel) {
        navigation?.popToViewController(firstViewController!, animated: true)
    }
}

extension FlowCoordinator: TemporaryViewModelDelegate {
    func startFlow(_ viewModel: TemporaryViewModel) {
        flowViewModel = FlowViewModel()
        flowViewModel?.delegate = self
        firstViewController = FirstViewController(viewModel: flowViewModel!, presentationType: flowType)
        navigation?.viewControllers.removeAll { $0 === temporaryViewController }
        navigation?.pushViewController(firstViewController!, animated: false)
    }
}

extension FlowCoordinator {
    enum FlowType {
        case modal
        case push
    }
}
    
