//
//  CustomPresentedViewController.swift
//  ViewTransition
//
//  Created by Fábio Salata on 14/11/19.
//  Copyright © 2019 Fábio Salata. All rights reserved.
//

import UIKit

class CustomPresentedViewController: UIViewController {
    
    var hideAnimator: CustomModalHideAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = self
        
        hideAnimator = CustomModalHideAnimator(withViewController: self)
    }
}

extension CustomPresentedViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomModalShowAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return hideAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return hideAnimator
    }
}
