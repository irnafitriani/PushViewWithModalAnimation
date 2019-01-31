//
//  CustomAnimator.swift
//  PushViewWithModalAnimation
//
//  Created by irna on 31/01/19.
//  Copyright © 2019 irna. All rights reserved.
//

import Foundation
import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration = 0.5
    var popStyle = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if popStyle{
            animatePop(using: transitionContext)
        }else{
            animatePush(using: transitionContext)
        }
    }
    
    func animatePush(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let finalFrameForVC = transitionContext.finalFrame(for: toVC)
        let containerView = transitionContext.containerView
        
        let bounds = UIScreen.main.bounds
        
        toVC.view.frame = toVC.view.frame.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview(toVC.view)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.0, options: .curveLinear,
                       animations: {
                        fromVC.view.alpha = 0.5
                        toVC.view.frame = finalFrameForVC
        }, completion: { finished in
            transitionContext.completeTransition(true)
            fromVC.view.alpha = 1.0
            
        })
        
    }
    
    func animatePop(using transitionContext: UIViewControllerContextTransitioning){
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let finalFrameForVC = transitionContext.finalFrame(for: toVC)
        let containerView = transitionContext.containerView
        
        let bounds = UIScreen.main.bounds
        
        toVC.view.frame = toVC.view.frame.offsetBy(dx: 0, dy: bounds.size.height)
        containerView.addSubview(toVC.view)
        toVC.view.frame = finalFrameForVC
        toVC.view.alpha = 0.5
        toVC.view.transform = .identity
        containerView.addSubview(toVC.view)
        containerView.sendSubviewToBack(toVC.view)
        
        let snapshotView = fromVC.view.snapshotView(afterScreenUpdates: false)
        snapshotView?.frame = fromVC.view.frame
        containerView.addSubview(snapshotView!)
        
        fromVC.view.removeFromSuperview()
        
        let options = UIView.AnimationOptions(rawValue: 6 << 16)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: options, animations: {
            snapshotView?.frame.origin.y = fromVC.view.frame.maxY + 12
            toVC.view.alpha = 1.0
        }) { finished in
            
            let isCancelled = transitionContext.transitionWasCancelled
            
            if !isCancelled {
                fromVC.view.removeFromSuperview()
            }
            
            transitionContext.completeTransition(!isCancelled)
            
        }
    }
}
