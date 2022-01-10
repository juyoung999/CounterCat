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
       @IBOutlet weak var reset: UIButton!
       
       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
           stepper.transform = stepper.transform.scaledBy(x: 3.0, y: 2.5)
           stepper.maximumValue = 1000
       }

       @IBAction func updownStepper(_ sender: UIStepper) {
           lblCount.text = Int(sender.value).description
       //    AudioServicesPlaySystemSound(1520)
       }
    
   /*    @IBAction func reset(_ sender: UIButton){
           label.text = "0"
           stepper.value = Double(0)
           AudioServicesPlaySystemSound(1520)
       }
*/
}
