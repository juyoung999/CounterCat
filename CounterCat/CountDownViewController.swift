//
//  CountDownViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/10.
//

import UIKit
import AudioToolbox

class CountDownViewController: UIViewController {

    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var bbtnReset: UIBarButtonItem!
    @IBOutlet weak var bbtnSetting: UIBarButtonItem!
       
    var vibrate : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // navigationController?.setNavigationBarHidden(false, animated: true)
        stepper.transform = stepper.transform.scaledBy(x: 3.0, y: 2.5)
        stepper.maximumValue = 1000
        
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
    }

    override func viewWillAppear(_ animated: Bool) {
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
    }
    
    @IBAction func updownStepper(_ sender: UIStepper) {
        if vibrate{
            AudioServicesPlaySystemSound(1519)
        }
        lblCount.text = Int(sender.value).description
    }
    
    @IBAction func reset(_ sender: UIButton){
        if vibrate{
            AudioServicesPlaySystemSound(1519)
        }
        lblCount.text = "0"
        stepper.value = Double(0)
       
    }

}
