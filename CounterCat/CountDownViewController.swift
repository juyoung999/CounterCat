//
//  CountDownViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/10.
//

import UIKit

class CountDownViewController: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var bbtnReset: UIBarButtonItem!
    @IBOutlet weak var bbtnSetting: UIBarButtonItem!
       
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         navigationController?.setNavigationBarHidden(false, animated: true)
        stepper.transform = stepper.transform.scaledBy(x: 3.0, y: 2.5)
        stepper.maximumValue = 1000
    }

    @IBAction func updownStepper(_ sender: UIStepper) {
        lblCount.text = Int(sender.value).description
    //    AudioServicesPlaySystemSound(1520)
    }
    
    @IBAction func reset(_ sender: UIButton){
        lblCount.text = "0"
        stepper.value = Double(0)
    //   AudioServicesPlaySystemSound(1520)
    }

}
