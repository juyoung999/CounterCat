//
//  ViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/09.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController, CountOptionDelegate {


    @IBOutlet var lblCount: UILabel!
    @IBOutlet var bbtnsetting: UIBarButtonItem!
    @IBOutlet var bbtnReset: UIBarButtonItem!
    
    var vibrate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let slideUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.slideScreen(_:)))
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.slideScreen(_:)))
        
        slideUp.direction = UISwipeGestureRecognizer.Direction.up
        slideDown.direction = UISwipeGestureRecognizer.Direction.down
        
        self.view.addGestureRecognizer(slideUp)
        self.view.addGestureRecognizer(slideDown)
    }

    func didChangeOption(_ controller: SettingTableViewController, option: Int) {
        switch option{
        case 0:
            break;
        case 1:
            performSegue(withIdentifier: "sgDown", sender: self)
            break;
        case 2:
            break;
        default:
            break;
        }
    }
    
    
    @objc func slideScreen(_ gesture: UISwipeGestureRecognizer){
        if gesture.direction == UISwipeGestureRecognizer.Direction.up{
                lblCount.text = String(Int(lblCount.text!)! + 1)
        }else{
            lblCount.text = String(Int(lblCount.text!)! - 1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touch = touches.count
        
        lblCount.text = String(Int(lblCount.text!)! + 1)
        if vibrate{
            AudioServicesPlaySystemSound(1520)
        }
    }
    
    @IBAction func resetCount(sender: UIButton){
        lblCount.text = "0"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDown"{
            let countDownView = segue.destination as! CountDownViewController
            countDownView.modalPresentationStyle = .fullScreen
        }
        if segue.identifier == "sgSetting"{
            let settingController = segue.destination as! SettingTableViewController
            settingController.delegate = self
        }
    }
 
}

