//
//  Wizard.swift
//  WizardFlow
//
//  Created by Dani Manuel on 9/27/17.
//  Copyright © 2017 Dani Manuel Céspedes Lara. All rights reserved.
//

import Foundation
import UIKit

public class Wizard: UIView{

    public enum NavigationDirection: Int{
        case next = 0, previous = 1
    }
    
    var currentStep: WizardStep!
    public var dataSource: WizardDataSource!
    public var delegate: WizardDelegate?
    
    private var isNavigating: Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    /// Display the first step
    public func displaySteps(){
        self.installFirstStep()
    }
    
    private func installFirstStep(){
        let firstStep = self.dataSource.firstStep(forWizard: self)
        self.currentStep = firstStep
        self.currentStep.stepWillShow(in: self)
        self.installStep(self.currentStep, isHidden: false)
        self.currentStep.stepDidShow(in: self)
    }


    /// Navigate to specific step based with an navigation direction
    ///
    public func navigate(to targetStep: WizardStep, direction: Wizard.NavigationDirection, completion: @escaping (() -> Void) = {}){
        guard !self.isNavigating else {return}
        guard self.currentStep.stepIdentifier != targetStep.stepIdentifier else {return}

        func navigationCompletionHandler(){
            self.isNavigating = false
            self.currentStep.stepDidHide(in: self)
            targetStep.stepDidShow(in: self)
            self.delegate?.wizard(self, didNavigateToStep: targetStep, from: self.currentStep)
            self.currentStep = targetStep
            completion()
        }

        func navigate(){
            self.installStep(targetStep)
            
            self.currentStep.stepWillHide(in: self)
            targetStep.stepWillShow(in: self)

            self.delegate?.wizard(self, willNavigateToStep: targetStep, from: self.currentStep)

            self.isNavigating = true
            if let delegate = self.delegate{
                delegate.wizard(self, animateNavigationFromStep: self.currentStep, to: targetStep, direction: direction, completion: {
                    navigationCompletionHandler()
                })
            }else{
                self.animateNavigation(from: self.currentStep, to: targetStep, direction: direction, completion: {
                    navigationCompletionHandler()
                })
            }
        }
        
        if direction == .previous{
            navigate()
            return
        }

        self.currentStep.taskBeforeNavigate(toNextStep: targetStep, in: self) {
            if let delegate = self.delegate{
                delegate.wizard(self, taskBeforeNavigateFromStep: self.currentStep, to: targetStep, completion: {
                    navigate()
                })
            }else{
                navigate()
            }
        }
    }


    /// Navigate to the next step in the wizard flow
    ///
    public func navigateToNextStep(completion: @escaping (() -> Void) = {}){
        guard !self.isNavigating else {return}
        
        guard let nextStep = self.dataSource.wizard(self, stepAfter: self.currentStep) else{
            if let delegate = self.delegate{
                delegate.wizard(self, taskBeforeNavigateFromStep: self.currentStep, to: nil, completion: {
                    delegate.wizardDidFinished(self)
                })
            }
            return
        }
        
        self.navigate(to: nextStep, direction: .next, completion: completion)
    }


    /// Navigate to the revious step in the wizard flow
    ///
    public func navigateToPreviousStep(completion: @escaping (() -> Void) = {}){
        guard !self.isNavigating else {return}
        guard let previousStep = self.dataSource.wizard(self, stepBefore: self.currentStep) else {return}
        
        self.navigate(to: previousStep, direction: .previous, completion: completion)
    }
    
    private func installStep(_ step: WizardStep, isHidden: Bool = true){
        
        guard !self.subviews.contains(step.view) else {return}
        
        step.view.translatesAutoresizingMaskIntoConstraints = false
        step.view.isHidden = isHidden
        self.addSubview(step.view)
        self.addConstraintToStep(step)
    }
    
    private func addConstraintToStep(_ step: WizardStep){
        let views: [String : Any] = ["stepView": step.view]

        let constraints = [
            NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stepView]-0-|", options: [], metrics: nil, views: views),
            NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stepView]-0-|", options: [], metrics: nil, views: views)
        ]

        NSLayoutConstraint.activate(constraints.flatMap{$0})
    }


    /// Default animation for navigation
    ///
    /// - Parameters:
    ///   - sourceStep: Step taht will be hidden
    ///   - targetStep: Step that will be shown
    ///   - direction: The navigation direction
    ///   - completion: Callback called when the animation finish
    internal func animateNavigation(from sourceStep: WizardStep, to targetStep: WizardStep, direction: Wizard.NavigationDirection, completion: @escaping () -> Void){

        let widthOfContainer = self.frame.size.width

        let leftTranslation = CGAffineTransform(translationX: -widthOfContainer , y: 0)
        let rightTranslation = CGAffineTransform(translationX: widthOfContainer, y: 0)

        let stepInTranslation = direction == .next ? rightTranslation : leftTranslation
        let stepOutTranslation = direction == .next ? leftTranslation : rightTranslation

        targetStep.view.transform = CGAffineTransform.identity
        targetStep.view.transform = stepInTranslation
        targetStep.view.isHidden = false

        DispatchQueue.main.async {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    targetStep.view.transform = CGAffineTransform.identity
                    sourceStep.view.transform = stepOutTranslation
            }, completion: { success in
                sourceStep.view.isHidden = true
                completion()
            })
        }
    }

}
