//
//  UIViewController.swift
//  RainyDay
//
//  Created by Mthokozisi Malaza on 2023/10/08.
//

import UIKit
import Lottie


private var animationView: LottieAnimationView?

extension UIViewController {
    
    //MARK: - Loading view
    func showLoadingView() {
        animationView = .init(name: "loading")
        animationView?.backgroundColor = .white
        animationView!.frame = self.view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.4
        self.view.addSubview(animationView!)
        animationView!.play()
    }
    
    func hideLoadingView() {
        animationView?.stop()
        animationView?.removeFromSuperview()
    }
}
