//
//  Step.swift
//  WizardFlow
//
//  Created by Dani Manuel on 9/27/17.
//  Copyright © 2017 Dani Manuel Céspedes Lara. All rights reserved.
//

import UIKit


/// Represent a Step in the flow
public protocol WizardStep{

    var stepIdentifier: String! {get set}
    
    var view: UIView! {get set}

    /// Notifiy the step that will be shown
    ///
    /// - Parameter wizard: The Wizard showing the step
    ///
    func stepWillShow(in wizard: Wizard)


    /// Notify the step tht did show
    ///
    /// - Parameter wizard: The Wizard showing the step
    func stepDidShow(in wizard: Wizard)


    /// Notifiy the step that will be hide
    ///
    /// - Parameter wizard: The Wizard hiding the step
    func stepWillHide(in wizard: Wizard)


    /// Notify the step that did hide
    ///
    /// - Parameter wizard: The Wizard hiding the step
    func stepDidHide(in wizard: Wizard)


    /// Ask to step to do some task if needed before navigate to other step
    ///
    /// - Parameters:
    ///   - nextStep: The step that will be show after task finish
    ///   - wizard: The Wizard managing the step
    ///   - completion: Call this clausure when the task did finished
    func taskBeforeNavigate(toNextStep nextStep: WizardStep, in wizard: Wizard, completion: @escaping () -> Void)
}

// MARK: - Default implementation for step methods
public extension WizardStep{
    public func stepWillShow(in wizard: Wizard){}
    public func stepDidShow(in wizard: Wizard){}
    public func stepWillHide(in wizard: Wizard){}
    public func stepDidHide(in wizard: Wizard){}
    public func taskBeforeNavigate(toNextStep nextStep: WizardStep, in wizard: Wizard, completion: @escaping () -> Void){completion()}
}
