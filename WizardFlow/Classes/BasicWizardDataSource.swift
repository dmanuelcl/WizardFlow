//
//  BasicWizardDataSource.swift
//  WizardFlow
//
//  Created by Dani Manuel on 9/27/17.
//  Copyright © 2017 Dani Manuel Céspedes Lara. All rights reserved.
//

import Foundation


/// Helper protocol to conform WizardDataSource with basic functionalities, in your code you can conform from this protocol and quickly setup your wizard
public protocol BasicWizardDataSource: WizardDataSource{
    var wizardSteps: [WizardStep] {get set}
}


// MARK: - Implementation of data source methods
extension BasicWizardDataSource{
    func indexForStep(_ step: WizardStep) -> Int?{
        return self.wizardSteps.index(where: { $0.stepIdentifier == step.stepIdentifier })
    }

    public func firstStep(forWizard wizard: Wizard) -> WizardStep {
        if self.wizardSteps.count == 0 {
            assertionFailure("The wizard need at least 1 step")
        }
        return self.wizardSteps.first!
    }

    public func wizard(_ wizard: Wizard, stepAfter step: WizardStep) -> WizardStep? {
        guard let index = self.indexForStep(step), index < self.wizardSteps.count - 1 else {
            return nil
        }
        return self.wizardSteps[index + 1]
    }

    public func wizard(_ wizard: Wizard, stepBefore step: WizardStep) -> WizardStep? {
        guard let index = self.indexForStep(step), index > 0 else {
            return nil
        }
        return self.wizardSteps[index - 1]
    }
}
