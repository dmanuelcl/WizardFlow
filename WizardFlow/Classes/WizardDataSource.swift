//
//  WizardDataSource.swift
//  WizardFlow
//
//  Created by Dani Manuel on 9/27/17.
//  Copyright © 2017 Dani Manuel Céspedes Lara. All rights reserved.
//

import Foundation

/// Define the data store used to build the wizard flow
public protocol WizardDataSource{

    /// Retrive the first step on the wizard
    ///
    /// - Parameter wizard: The Wizard showing the steps
    /// - Returns: The first step to show
    func firstStep(forWizard wizard: Wizard) -> WizardStep


    /// Retrive the step before the given step
    ///
    /// - Parameters:
    ///   - wizard: The Wizard showing the steps
    ///   - sourceStep: The step used to calculate the new step
    /// - Returns: The step showed before the given step
    func wizard(_ wizard: Wizard, stepBefore sourceStep: WizardStep) -> WizardStep?


    /// Retrive the step after the given step
    ///
    /// - Parameters:
    ///   - wizard: The Wizard showing the steps
    ///   - sourceStep: The step used to calculate the new step
    /// - Returns: The step showed after the given step
    func wizard(_ wizard: Wizard, stepAfter sourceStep: WizardStep) -> WizardStep?
}
