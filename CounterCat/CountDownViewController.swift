//
//  CountDownViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/10.
//

import UIKit
import AudioToolbox

class CountDownViewController: UIViewController{
    
    var vibrate : Bool!
    var targetValue : String?
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var bbtnReset: UIBarButtonItem!
    @IBOutlet weak var bbtnSetting: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        stepper.transform = stepper.transform.scaledBy(x: 3.0, y: 2.5)
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
    }

    override func viewWillAppear(_ animated: Bool) {
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
        targetValue = UserDefaults.standard.string(forKey: "targetText")
    }
    
    @IBAction func updownStepper(_ sender: UIStepper) {
        if vibrate{
            AudioServicesPlaySystemSound(1519)
        }
        lblCount.text = Int(sender.value).description
        
        if let targetValue = targetValue {
           if lblCount.text == targetValue{
                view.backgroundColor = UIColor.yellow
           }else if lblCount.text == String(Int(targetValue)! + 1) || lblCount.text == String(Int(targetValue)! - 1){
               view.backgroundColor = UIColor.systemBackground
           }
        }
    }
    
    @IBAction func reset(_ sender: UIButton){
        lblCount.text = "0"
        stepper.value = Double(0)
        view.backgroundColor = UIColor.systemBackground
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
