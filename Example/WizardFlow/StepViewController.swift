//
//  StepViewController.swift
//  WizardFlow_Example
//
//  Created by Dani Manuel Céspedes Lara on 2/20/18.
//  Copyright © 2018 Dani Manuel Céspedes Lara. All rights reserved.
//

import UIKit
import WizardFlow

class StepViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    var stepIdentifier: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Conform to WizardStep protocol
extension StepViewController: WizardStep{

}
