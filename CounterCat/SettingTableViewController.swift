//
//  SettingTableViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/10.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    var option : String?
    @IBOutlet var pkOption: UIPickerView!
    @IBOutlet var bbtnComplete: UIBarButtonItem!
    @IBOutlet var swVibrate: UISwitch!
    @IBOutlet var swTarget: UISwitch!
    @IBOutlet var tfTaget: UITextField!
    @IBOutlet var swDarkMode: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swVibrate.isOn = UserDefaults.standard.bool(forKey: "swVibrateState")
        swTarget.isOn = UserDefaults.standard.bool(forKey: "swTargetValue")
        tfTaget.isEnabled = UserDefaults.standard.bool(forKey: "swTargetValue")
        tfTaget.text = UserDefaults.standard.string(forKey: "targetText")
        swDarkMode.isOn = UserDefaults.standard.bool(forKey: "swDarkMode")
        UserDefaults.standard.bool(forKey: "swDarkMode") ? (overrideUserInterfaceStyle = .dark) : (overrideUserInterfaceStyle = .light)
        pkOption.selectRow(UserDefaults.standard.integer(forKey: "optionPickerRow"), inComponent: 0, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    @IBAction func touchCompleteButton(sender: UIBarButtonItem){
        if swTarget.isOn{
            if tfTaget.text != ""{
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
        let oldRow = UserDefaults.standard.integer(forKey: "optionPickerRow")
        let newRow = pkOption.selectedRow(inComponent: 0)
       
        if oldRow != newRow{
            UserDefaults.standard.set(pkOption.selectedRow(inComponent: 0), forKey: "optionPickerRow")
            switch newRow{
            case 0:
                self.navigationController?.popToRootViewController(animated: true)
            case 1:
                performSegue(withIdentifier: "sgCountDown", sender: self)
            case 2:
                performSegue(withIdentifier: "sgSlide", sender: self)
            default:
                break;
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
        UserDefaults.standard.set(sender.isOn, forKey: "swTargetValue")
    }
    
    @IBAction func changeVibrateSwitch(_ sender: UISwitch){
        UserDefaults.standard.set(sender.isOn, forKey: "swVibrateState")
    }
    
    @IBAction func changeDarkSwitch(_ sender: UISwitch){
        sender.isOn ? (overrideUserInterfaceStyle = .dark) : (overrideUserInterfaceStyle = .light)
        UserDefaults.standard.set(sender.isOn, forKey: "swDarkMode")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgCountDown"{
            let countdownController = segue.destination as! CountDownViewController
            countdownController.modalPresentationStyle = .fullScreen
        }else if segue.identifier == "sgSlide"{
            let slideController = segue.destination as! SlideCountController
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
}

