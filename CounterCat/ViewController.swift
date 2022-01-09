//
//  ViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/09.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblCount: UILabel!
    @IBOutlet var btnSetting: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touch = touches.count
        
        lblCount.text = String(Int(lblCount.text!)! + 1)
    }
    
    @IBAction func clickSetting(sender: UIBarButtonItem){
        let settindAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        settindAlert.addAction(UIAlertAction(title: "카운트다운", style: .default))
        settindAlert.addAction(UIAlertAction(title: "카운트", style: .default))
        settindAlert.addAction(UIAlertAction(title: "설정", style: .default))
        settindAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(settindAlert, animated: true)
    }
    
 /*
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var reset: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        stepper.transform = stepper.transform.scaledBy(x: 3.3, y: 2.8)
        stepper.maximumValue = 1000
    }

    @IBAction func updownStepper(_ sender: UIStepper) {
        label.text = Int(sender.value).description
        AudioServicesPlaySystemSound(1520)
    }
 
    @IBAction func reset(_ sender: UIButton){
        label.text = "0"
        stepper.value = Double(0)
        AudioServicesPlaySystemSound(1520)
    }
*/
}

