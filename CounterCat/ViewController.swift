//
//  ViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/09.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController{

    @IBOutlet var lblCount: UILabel!
    @IBOutlet var bbtnsetting: UIBarButtonItem!
    @IBOutlet var bbtnReset: UIBarButtonItem!

    var vibrate : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
    }

    @objc func slideScreen(_ gesture: UISwipeGestureRecognizer){
        
            if vibrate{
                AudioServicesPlaySystemSound(1520)
            }
            if gesture.direction == UISwipeGestureRecognizer.Direction.up{
                    lblCount.text = String(Int(lblCount.text!)! + 1)
            }else{
                lblCount.text = String(Int(lblCount.text!)! - 1)
            }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            if vibrate{
                AudioServicesPlaySystemSound(1520)
            }
            lblCount.text = String(Int(lblCount.text!)! + 1)
    }
    
    @IBAction func resetCount(sender: UIButton){
        lblCount.text = "0"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
 
}

