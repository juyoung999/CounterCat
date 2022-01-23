//
//  SlideCountController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/13.
//

import UIKit
import AudioToolbox

class SlideCountController: UIViewController, CountSettingDelegate{
    
    var vibrate : Bool!
    var targetValue : String?
    @IBOutlet var lblCount: UILabel!
    @IBOutlet var bbtnsetting: UIBarButtonItem!
    @IBOutlet var bbtnReset: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
        addSlideGesture()
    }
    
    func addSlideGesture(){
        let slideUp = UISwipeGestureRecognizer(target: self, action: #selector(SlideCountController.slideScreen(_:)))
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(SlideCountController.slideScreen(_:)))
        slideUp.direction = UISwipeGestureRecognizer.Direction.up
        slideDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(slideUp)
        self.view.addGestureRecognizer(slideDown)
    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  vibrate = UserDefaults.standard.bool(forKey: "swVibrateState")
    }
    

    @objc func slideScreen(_ gesture: UISwipeGestureRecognizer){
        if vibrate{
            AudioServicesPlaySystemSound(1519)
        }
        if gesture.direction == UISwipeGestureRecognizer.Direction.up{
                lblCount.text = String(Int(lblCount.text!)! + 1)
        }else{
            if lblCount.text != "0"{
                lblCount.text = String(Int(lblCount.text!)! - 1)
            }
        }
        if let targetValue = targetValue {
           if lblCount.text == targetValue{
                view.backgroundColor = UIColor.yellow
           }else if lblCount.text == String(Int(targetValue)! + 1) || lblCount.text == String(Int(targetValue)! - 1){
               view.backgroundColor = UIColor.systemBackground
           }
        }
    }

    func didChangeTarget(_ controller: SettingTableViewController, target: String?) {
        targetValue = target
    }
    
    func didChangeVibrate(_ controller: SettingTableViewController, vibrate: Bool) {
        self.vibrate = vibrate
    }
    
    @IBAction func resetCount(sender: UIButton){
        lblCount.text = "0"
        view.backgroundColor = UIColor.systemBackground
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgSettingSlide"{
            let setController = segue.destination as! SettingTableViewController
            setController.delegate = self
        }
    }
 
}


