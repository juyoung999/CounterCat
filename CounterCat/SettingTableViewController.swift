//
//  SettingTableViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/10.
//

import UIKit

class SettingTableViewController: UITableViewController {

    @IBOutlet var pkOption: UIPickerView!
    @IBOutlet var bbtnComplete: UIBarButtonItem!
    @IBOutlet var swVibrate: UISwitch!

    var option : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swVibrate.isOn = UserDefaults.standard.bool(forKey: "swVibrateState")
        
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
    
    @IBAction func changeVibrateSwitch(_ sender: UISwitch){
        UserDefaults.standard.set(sender.isOn, forKey: "swVibrateState")
    }
    
    @IBAction func chanedOptionPicker(_ sender: UIPickerView){
        
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(pkOption.selectedRow(inComponent: 0), forKey: "optionPickerRow")
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

