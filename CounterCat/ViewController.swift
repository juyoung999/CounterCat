//
//  ViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/09.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    var vibrate : Bool!
    var targetValue : String?
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var bbtnsetting: UIBarButtonItem!
    @IBOutlet var bbtnReset: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(0, forKey: "optionPickerRow")
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
        if UserDefaults.standard.bool(forKey: "swTargetValue"){
            targetValue = UserDefaults.standard.string(forKey: "targetText")
        }
        UserDefaults.standard.bool(forKey: "swDarkMode") ? (overrideUserInterfaceStyle = .dark) : (overrideUserInterfaceStyle = .light)
    }

    override func viewWillAppear(_ animated: Bool) {
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
        UserDefaults.standard.bool(forKey: "swTargetValue") ? (targetValue = UserDefaults.standard.string(forKey: "targetText")) : (targetValue = nil)
        UserDefaults.standard.bool(forKey: "swDarkMode") ? (overrideUserInterfaceStyle = .dark) : (overrideUserInterfaceStyle = .light)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if vibrate{AudioServicesPlaySystemSound(1519)}
        lblCount.text = String(Int(lblCount.text!)! + 1)
        if let targetValue = targetValue {
           if lblCount.text == targetValue{
               view.backgroundColor = UIColor.yellow
           }else if lblCount.text == String(Int(targetValue)! + 1){
               view.backgroundColor = UIColor.systemBackground
           }
        }
    }
    
    
    @IBAction func resetCount(sender: UIButton){
        lblCount.text = "0"
        view.backgroundColor = UIColor.systemBackground
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}

