//
//  StepNib.swift
//  WizardFlow_Example
//
//  Created by Dani Manuel Céspedes Lara on 2/20/18.
//  Copyright © 2018 Dani Manuel Céspedes Lara. All rights reserved.
//

import Foundation
import WizardFlow

class StepNib: NSObject, WizardStep {
    var stepIdentifier: String!

    @IBOutlet var view: UIView!
    @IBOutlet var label: UILabel!

    func loadView(){
        if let view = Bundle.main.loadNibNamed("StepNib", owner: self, options: nil)?.first as? UIView{
            self.view = view
        }
    }

}
