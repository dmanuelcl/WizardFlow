//
//  CommonWizardDelegate.swift
//  WizardFlow_Example
//
//  Created by Dani Manuel Céspedes Lara on 2/20/18.
//  Copyright © 2018 Dani Manuel Céspedes Lara. All rights reserved.
//

import Foundation
import WizardFlow

class CommonWizardDelegate: WizardDelegate {

    //    func wizard(_ wizard: Wizard, animateNavigationFromStep sourceStep: WizardStep, to targetStep: WizardStep, direction: Wizard.NavigationDirection, completion: @escaping () -> Void) {
    //            //Here your own navigation
    //        completion()
    //    }

    func wizard(_ wizard: Wizard, taskBeforeNavigateFromStep sourceStep: WizardStep, to targetStep: WizardStep?, completion: @escaping () -> Void) {
        print(#function, sourceStep.stepIdentifier, targetStep?.stepIdentifier as Any)
        //Make some validation or network request, con completion call completion()
        completion()
    }

    func wizard(_ wizard: Wizard, willNavigateToStep targetStep: WizardStep, from sourceStep: WizardStep) {
        print(#function, targetStep.stepIdentifier, sourceStep.stepIdentifier)
    }

    func wizard(_ wizard: Wizard, didNavigateToStep targetStep: WizardStep, from sourceStep: WizardStep) {
        print(#function, targetStep.stepIdentifier, sourceStep.stepIdentifier)
    }

    func wizardDidFinished(_ wizard: Wizard) {
        print(#function)
        let alert = UIAlertController(title: "Wizard Finish", message: "The wizard flow did finish", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
