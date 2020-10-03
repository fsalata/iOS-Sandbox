//
//  ImageViewerHideAnimation.swift
//  ViewTransition
//
//  Created by Fábio Salata on 14/11/19.
//  Copyright © 2019 Fábio Salata. All rights reserved.
//

import UIKit

class ImageViewerHideAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    var animator: UIViewPropertyAnimator?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if let currentAnimator = self.animator {
            return currentAnimator
        }
        
        guard let toViewController = transitionContext.viewController(forKey: .to) as? ViewController,
            let fromViewController = transitionContext.viewController(forKey: .from) as? ImageViewerViewController
            else {
                return UIViewPropertyAnimator()
        }
        
        transitionContext.containerView.addSubview(toViewController.view)
        transitionContext.containerView.addSubview(fromViewController.view)
        
        let animationTiming = UICubicTimingParameters(animationCurve: .easeInOut)
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), timingParameters: animationTiming)
        
        
        fromViewController.view.clipsToBounds = true
        
        animator.addAnimations {
            let endFrame = toViewController.imageViewButton.frame
            
            fromViewController.view.frame = endFrame
            fromViewController.view.layer.cornerRadius = endFrame.height / 2
        }
        
        animator.addCompletion { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        self.animator = animator
        
        return animator
    }
}
