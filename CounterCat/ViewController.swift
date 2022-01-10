//
//  ViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/09.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet var lblCount: UILabel!
    @IBOutlet var bbtnsetting: UIBarButtonItem!
    @IBOutlet var bbtnReset: UIBarButtonItem!
    
    var vibrate = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let slideUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.slideScreen(_:)))
        slideUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(slideUp)
        
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.slideScreen(_:)))
        slideDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(slideDown)
    }

    @objc func slideScreen(_ gesture: UISwipeGestureRecognizer){
        if gesture.direction == UISwipeGestureRecognizer.Direction.up{
                lblCount.text = String(Int(lblCount.text!)! + 1)
        }else{
            lblCount.text = String(Int(lblCount.text!)! - 1)
        }
    }
 /*   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //let touch = touches.count
        
        lblCount.text = String(Int(lblCount.text!)! + 1)
        if vibrate{
            AudioServicesPlaySystemSound(1520)
        }
    }
   */

    
    @IBAction func clickSetting(sender: UIBarButtonItem){
        let settindAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
     
        settindAlert.addAction(UIAlertAction(title: "카운트", style: .default))
        settindAlert.addAction(UIAlertAction(title: "카운트다운", style: .default){_ in
            self.performSegue(withIdentifier: "sgDown", sender: self)
        })
        settindAlert.addAction(UIAlertAction(title: "설정", style: .default))
        settindAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        present(settindAlert, animated: true)
    }
    
    @IBAction func resetCount(sender: UIButton){
        lblCount.text = "0"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDown"{
            let countdown = segue.destination as! CountDownViewController
        }
    }
 
}

