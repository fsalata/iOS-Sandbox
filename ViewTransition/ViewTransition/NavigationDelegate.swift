//
//  NavigationDelegate.swift
//  ViewTransition
//
//  Created by Fábio Salata on 14/11/19.
//  Copyright © 2019 Fábio Salata. All rights reserved.
//

import UIKit

class NavigationDelegate: NSObject {
    let navigationController: UINavigationController
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        super.init()
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        navigationController.view.addGestureRecognizer(panRecognizer)
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let view = navigationController.view else { return }
        
        switch recognizer.state {
        case .began:
            let location = recognizer.location(in: view)
            
            if location.x < view.bounds.midX && navigationController.viewControllers.count > 1 {
                interactionController = UIPercentDrivenInteractiveTransition()
                navigationController.popViewController(animated: true)
            }
        case .changed:
            let panTranslation = recognizer.translation(in: view)
            let animationProgress = abs(panTranslation.x / view.bounds.width)
            interactionController?.update(animationProgress)
            break
        default:
            if recognizer.velocity(in: view).x > 0 {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            
            interactionController = nil
        }
    }
}

extension NavigationDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return ImageViewerHideAnimation()
        } else {
            return ImageViewerShowAnimation()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}
