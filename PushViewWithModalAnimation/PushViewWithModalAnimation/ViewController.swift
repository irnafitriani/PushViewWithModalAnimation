//
//  ViewController.swift
//  PushViewWithModalAnimation
//
//  Created by irna on 31/01/19.
//  Copyright © 2019 irna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {
    
    var customAnimator = CustomAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        customAnimator.popStyle = (operation == .pop)
        
        return customAnimator
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "ShowSecondPage", sender: self)
    }
    
}

