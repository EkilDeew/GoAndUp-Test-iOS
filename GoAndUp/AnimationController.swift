//
//  AnimationController.swift
//  GoAndUp
//
//  Created by Guillaume Fourrier on 26/02/2021.
//

import UIKit

class CardAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        
        let initialFrame = originFrame
        let finalFrame = toView.frame
        
        let xScaleFactor = initialFrame.width / finalFrame.width
        let yScaleFactor = initialFrame.height / finalFrame.height
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        toView.transform = scaleTransform
        toView.center = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
        toView.clipsToBounds = true
        
        toView.layer.cornerRadius = 5.0
        toView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(toView)
        
        UIView.animate(withDuration: 0.3) {
            toView.transform = .identity
            toView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            toView.layer.cornerRadius = 5.0
        } completion: { comp in
            transitionContext.completeTransition(comp)
        }
    }
    
    
}
