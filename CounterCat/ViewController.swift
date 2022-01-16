//
//  ViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/09.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, CountTargetDelegate{

    @IBOutlet var lblCount: UILabel!
    @IBOutlet var bbtnsetting: UIBarButtonItem!
    @IBOutlet var bbtnReset: UIBarButtonItem!

    var vibrate : Bool!
    var targetValue : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(0, forKey: "optionPickerRow")
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
    }
    
    func didChangeTarget(_ controller: SettingTableViewController, target: String) {
        targetValue = target
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if vibrate{
            AudioServicesPlaySystemSound(1520)
        }
        lblCount.text = String(Int(lblCount.text!)! + 1)
        if let targetValue = targetValue {
            if lblCount.text == targetValue{
                view.backgroundColor = UIColor.green
            }
        }
    }
    
    func alertTarget(_ target: String){
      //  lblCount.addObserver(self, forKeyPath: "10", options: [.old, .new], context: nil)
       
    }
    
    @IBAction func resetCount(sender: UIButton){
        lblCount.text = "0"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgViewSetting"{
            let setController = segue.destination as! SettingTableViewController
            setController.delegate = self
        }
    }
 
}

