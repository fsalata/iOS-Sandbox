//
//  HomeCoordinator.swift
//  CoordinatorsBase
//
//  Created by Fábio Salata on 13/08/20.
//

import Foundation

final class HomeCoordiantor: BaseCoordinator {
    var view: HomeViewController?
    var navigation: CustomNavigationController?
    var presentationType: PresentationType?
    
    var homeViewModel: HomeViewModel?
    var homeViewController: HomeViewController?
    
    var flowCoordinator: FlowCoordinator?
    
    func start() -> HomeViewController {
        homeViewModel = HomeViewModel()
        homeViewModel?.delegate = self
        homeViewController = HomeViewController(viewModel: homeViewModel!)
        return homeViewController!
    }
    
    func stop() {
        view = nil
        navigation = nil
        presentationType = nil
        homeViewModel = nil
        homeViewController = nil
        flowCoordinator = nil
    }
}

extension HomeCoordiantor: HomeViewModelDelegate {
    func startFlow(_ viewModel: HomeViewModel, isModal: Bool) {
        guard let navigation = navigation else { return  }
        
        flowCoordinator = FlowCoordinator()
        flowCoordinator?.start(usingPresentation: isModal ? .modal(viewController: navigation) : .push(navigationController: navigation))
    }
    
    
}
