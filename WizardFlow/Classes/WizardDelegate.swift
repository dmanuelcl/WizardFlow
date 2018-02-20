//
//  WizardDelegate.swift
//  WizardFlow
//
//  Created by Dani Manuel on 9/27/17.
//  Copyright © 2017 Dani Manuel Céspedes Lara. All rights reserved.
//

import Foundation

/// Delegate to notify the wizard navigation
public protocol WizardDelegate{

    /// Ask the delegate to make some task before navigate to nex step in the Wizard
    ///
    /// - Parameters:
    ///   - wizard: The Wizard showing the steps
    ///   - sourceStep: The current step
    ///   - targetStep: The step that will be shown
    ///   - completion: You should call the completion handler as soon as you've finished handling the action.
    func wizard(_ wizard: Wizard, taskBeforeNavigateFromStep sourceStep: WizardStep, to targetStep: WizardStep?, completion: @escaping () -> Void)


    /// Notify the delegate that the Wizard is about navigate to an step
    ///
    /// - Parameters:
    ///   - wizard: The Wizard showing the steps
    ///   - targetStep: The current step
    ///   - sourceStep: The step that will be shown
    func wizard(_ wizard: Wizard, willNavigateToStep targetStep: WizardStep, from sourceStep: WizardStep)


    /// Notify the delegate that the Wizard did navigate to an step
    ///
    /// - Parameters:
    ///   - wizard: The Wizard showing the steps
    ///   - targetStep: The step that did show
    ///   - sourceStep: The step that did hide
    func wizard(_ wizard: Wizard, didNavigateToStep targetStep: WizardStep, from sourceStep: WizardStep)

    /// Ask the delegate to animate the transition between steps
    ///
    /// - Parameters:
    ///   - wizard: The Wizard showing the steps
    ///   - sourceStep: The current step
    ///   - targetStep: The step that will be shown
    ///   - direction: The direction of navigation
    ///   - completion: You should call the completion handler as soon as you've finished handling the animation.
    func wizard(_ wizard: Wizard, animateNavigationFromStep sourceStep: WizardStep, to targetStep: WizardStep, direction: Wizard.NavigationDirection, completion: @escaping () -> Void)

    /// Notify the end of the flow to the delegate
    ///
    /// - Parameter wizard: The Wizard showing the steps
    func wizardDidFinished(_ wizard: Wizard)
}


// MARK: - Default implementation for delegate methods
public extension WizardDelegate{

    public func wizard(_ wizard: Wizard, taskBeforeNavigateFromStep sourceStep: WizardStep, to targetStep: WizardStep?, completion: @escaping () -> Void){
        completion()
    }

    public func wizard(_ wizard: Wizard, willNavigateToStep targetStep: WizardStep, from sourceStep: WizardStep){}

    public func wizard(_ wizard: Wizard, didNavigateToStep targetStep: WizardStep, from sourceStep: WizardStep){}

    public func wizard(_ wizard: Wizard, animateNavigationFromStep sourceStep: WizardStep, to targetStep: WizardStep, direction: Wizard.NavigationDirection, completion: @escaping () -> Void){
        wizard.animateNavigation(from: sourceStep, to: targetStep, direction: direction, completion: completion)
    }

    public func wizardDidFinished(_ wizard: Wizard){}
}
