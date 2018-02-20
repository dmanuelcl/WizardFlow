//
//  WizardViewController.swift
//  WizardFlow_Example
//
//  Created by Dani Manuel Céspedes Lara on 2/20/18.
//  Copyright © 2018 Dani Manuel Céspedes Lara. All rights reserved.
//

import UIKit
import WizardFlow

class WizardViewController: UIViewController {

    @IBOutlet weak var wizard: Wizard!
    var wizardSteps: [WizardStep] = []
    var commonDelegate = CommonWizardDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupWizardDataSource()
        self.wizard.dataSource = self
        self.wizard.delegate = self.commonDelegate
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wizard.displaySteps()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func stepFromStoryboard(withColor color: UIColor, at index: Int) -> WizardStep{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let step = storyboard.instantiateViewController(withIdentifier: "StepViewController") as! StepViewController
        let view = step.view
        view?.backgroundColor = color
        step.stepIdentifier = String(index)
        step.label.text = "Step #\(index)"
        return step
    }

    func stepFromNib(withColor color: UIColor, at index: Int) -> WizardStep{
        let stepNib = StepNib()
        stepNib.loadView()
        stepNib.view.backgroundColor = color
        stepNib.stepIdentifier = String(index)
        stepNib.label.text = "Step #\(index)"
        return stepNib
    }

    func setupWizardDataSource(){
        let colors: [UIColor] = [.red, .black, .brown, .cyan, .green, .blue, .gray]

        for i in 0..<colors.count{
            let index = i + 1
            let color = colors[i]
            if index % 2 == 0{
                self.wizardSteps.append(self.stepFromStoryboard(withColor: color, at: index))
            }else{
                self.wizardSteps.append(self.stepFromNib(withColor: color, at: index))
            }
        }
    }
    

    @IBAction func handleNextStep(_ sender: AnyObject){
        self.wizard.navigateToNextStep {
            print(#function, "navigation to next step did finish")
        }
    }

    @IBAction func handlePreviousStep(_ sender: AnyObject){
        self.wizard.navigateToPreviousStep {
            print(#function, "navigation to previous step did finish")
        }
    }

    
    @IBAction func handleNavigateToLastStep(_ sender: AnyObject){
        let step = self.wizardSteps.last!
        self.wizard.navigate(to: step, direction: .next)
    }
}

extension WizardViewController: BasicWizardDataSource{

}
