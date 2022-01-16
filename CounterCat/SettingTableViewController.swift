//
//  SettingTableViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/10.
//

import UIKit

protocol CountTargetDelegate{
    func didChangeTarget(_ controller: SettingTableViewController, target: String)
}

class SettingTableViewController: UITableViewController {

    @IBOutlet var pkOption: UIPickerView!
    @IBOutlet var bbtnComplete: UIBarButtonItem!
    @IBOutlet var swVibrate: UISwitch!
    @IBOutlet var swTarget: UISwitch!
    @IBOutlet var tfTaget: UITextField!
    
    var option : String?
    var delegate : CountTargetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swVibrate.isOn = UserDefaults.standard.bool(forKey: "swVibrateState")
        swTarget.isOn = UserDefaults.standard.bool(forKey: "swTargetValue")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pkOption.selectRow(UserDefaults.standard.integer(forKey: "optionPickerRow"), inComponent: 0, animated: true)
   
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    @IBAction func setComplete(sender: UIBarButtonItem){
        // self.navigationController?.popToRootViewController(animated: false)
        //  _ = navigationController?.popViewController(animated: true)
        UserDefaults.standard.set(swVibrate.isOn, forKey: "swVibrateState")
        UserDefaults.standard.set(pkOption.selectedRow(inComponent: 0), forKey: "optionPickerRow")
        UserDefaults.standard.set(swTarget.isOn, forKey: "swTargetValue")
            
        if tfTaget.text != nil && swTarget.isOn && delegate != nil{
            delegate?.didChangeTarget(self, target: tfTaget.text!)
        }
        
        if let select = option{
            if select == ""{
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                performSegue(withIdentifier: select, sender: self)
            }
        }else{
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clickBackButton(_ sender: UIBarButtonItem){
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchTargetValue(_ sender: UISwitch){
        sender.isOn ? (tfTaget.isEnabled = true) : (tfTaget.isEnabled = false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgCountDown"{
            let countdownController = segue.destination as! CountDownViewController
            if tfTaget.text != nil && swTarget.isOn{
                countdownController.targetValue = tfTaget.text
            }
            countdownController.modalPresentationStyle = .fullScreen
        }else if segue.identifier == "sgSlide"{
            let slideController = segue.destination as! SlideCountController
            if tfTaget.text != nil && swTarget.isOn{
                slideController.targetValue = tfTaget.text
            }
            slideController.modalPresentationStyle = .fullScreen
        }
    }
}

extension SettingTableViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let option = ["화면터치", "버튼터치", "슬라이드"]
        return option[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row{
        case 0:
            option = ""
            break;
        case 1:
            option = "sgCountDown"
            break;
        case 2:
            option = "sgSlide"
            break;
        default:
            break;
        }
    }
}

