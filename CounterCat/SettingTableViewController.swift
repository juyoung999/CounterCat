//
//  SettingTableViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/10.
//

import UIKit

protocol CountSettingDelegate{
    func didChangeTarget(_ controller: SettingTableViewController, target: String?)
    func didChangeVibrate(_ controller: SettingTableViewController, vibrate: Bool)
}

class SettingTableViewController: UITableViewController {
    
    var option : String?
    var delegate : CountSettingDelegate?
    @IBOutlet var pkOption: UIPickerView!
    @IBOutlet var bbtnComplete: UIBarButtonItem!
    @IBOutlet var swVibrate: UISwitch!
    @IBOutlet var swTarget: UISwitch!
    @IBOutlet var tfTaget: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swVibrate.isOn = UserDefaults.standard.bool(forKey: "swVibrateState")
        swTarget.isOn = UserDefaults.standard.bool(forKey: "swTargetValue")
        tfTaget.isEnabled = UserDefaults.standard.bool(forKey: "swTargetValue")
        tfTaget.text = UserDefaults.standard.string(forKey: "targetText")
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
        
        if swTarget.isOn && delegate != nil{
            if tfTaget.text != ""{
                delegate?.didChangeTarget(self, target: tfTaget.text!)
                UserDefaults.standard.set(tfTaget.text!, forKey: "targetText")
                popSettingView()
            }else{
                let notice = UIAlertController(title: "목표 미설정", message: "목표값을 입력해주세요.", preferredStyle: .alert)
                notice.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                self.present(notice, animated: true, completion: nil)
            }
        }else{
            popSettingView()
        }
    }
    
    func popSettingView(){
        if let select = option{
            if select == "touch"{
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
    
    @IBAction func changeTargetSwitch(_ sender: UISwitch){
        sender.isOn ? (tfTaget.isEnabled = true) : (tfTaget.isEnabled = false)
        if sender.isOn == false{
            if delegate != nil{
                delegate?.didChangeTarget(self, target: nil)
            }
        }
        UserDefaults.standard.set(sender.isOn, forKey: "swTargetValue")
    }
    
    @IBAction func changeVibrateSwitch(_ sender: UISwitch){
        UserDefaults.standard.set(sender.isOn, forKey: "swVibrateState")
        if delegate != nil{
            delegate?.didChangeVibrate(self, vibrate: sender.isOn)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgCountDown"{
            let countdownController = segue.destination as! CountDownViewController
           if tfTaget.text != "" && swTarget.isOn{
                countdownController.targetValue = tfTaget.text
            }
            countdownController.vibrate = swVibrate.isOn
            countdownController.modalPresentationStyle = .fullScreen
        }else if segue.identifier == "sgSlide"{
            let slideController = segue.destination as! SlideCountController
            if tfTaget.text != "" && swTarget.isOn{
                slideController.targetValue = tfTaget.text
            }
            slideController.vibrate = swVibrate.isOn 
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
        UserDefaults.standard.set(row, forKey: "optionPickerRow")
        switch row{
        case 0:
            option = "touch"
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

