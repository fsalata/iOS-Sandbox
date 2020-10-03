//
//  MainCoordinator.swift
//  AnimationsToTheNextLevel
//
//  Created by Aline Borges on 04/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit

final class MainCoordinator: Coordinator {
    
    let window: UIWindow
    
    weak var parentCoordinator: Coordinator?
    
    var currentCoordinator: Coordinator?
    
    var mainView: MainView!
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showMainView()
    }
    
    func showMainView() {
        let mainView = MainView()
        self.mainView = mainView
        mainView.coordinator = self
        self.window.rootViewController = mainView
    }
    
    func showTheBasics() {
        let views = [TheBasicsIntro.self]
        self.showFlow(withViews: views)
    }
    
    func showTheInteractive() {
        let views = [TheInteractiveView.self, FractionCompleteView.self, RuleOfThreeView.self]
        self.showFlow(withViews: views)
    }
    
    func showTheCurve() {
        let views = [TheCurveView.self, SluggishView.self]
        self.showFlow(withViews: views)
    }
    
    func showTheProperties() {
        let views = [PropertiesTransformView.self,
                     PropertiesColorView.self,
                     PropertiesBlurView.self,
                     PropertiesCornerRadiusView.self]
        self.showFlow(withViews: views)
    }
    
    func showTheOnboarding() {
        let views = [WorldOnboardingView.self]
        self.showFlow(withViews: views, toolbarHidden: true)
    }
    
    func showTheSlidingComments() {
        let views = [SliddingCommentsView.self]
        self.showFlow(withViews: views, toolbarHidden: true)
    }
    
    func showTheCollapsingHeader() {
        let views = [InstaNorrisView.self]
        self.showFlow(withViews: views, toolbarHidden: true)
    }
    
    private func showFlow(withViews views: [UIViewController.Type], toolbarHidden: Bool = false) {
        self.currentCoordinator = FlowCoordinator(mainView: self.mainView, views: views, toolbarHidden: toolbarHidden)
        self.currentCoordinator?.parentCoordinator = self
        self.currentCoordinator?.start()
    }
    
    func dismissCurrent() {
        self.mainView.dismiss(animated: true, completion: nil)
        self.currentCoordinator = nil
    }
    
}

extension MainCoordinator {
    
    func handle(_ action: Event) {
        switch action {
        case MainAction.theBasics:
            showTheBasics()
        case MainAction.theInteractive:
            showTheInteractive()
        case MainAction.theCurve:
            showTheCurve()
        case MainAction.theProperties:
            showTheProperties()
        case MainAction.theOnboarding:
            showTheOnboarding()
        case MainAction.theSlidingComments:
            showTheSlidingComments()
        case MainAction.theCollapsingHeader:
            showTheCollapsingHeader()
        case FlowAction.finish:
            dismissCurrent()
        default:
            break
        }
    }
    
}
