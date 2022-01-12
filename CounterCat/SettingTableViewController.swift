//
//  SettingTableViewController.swift
//  CounterCat
//
//  Created by 김주영 on 2022/01/10.
//

import UIKit

protocol CountSlideDelegate{
    func didChangeOption(_ controller: SettingTableViewController, touch: Bool)
}

class SettingTableViewController: UITableViewController {

    @IBOutlet var optPicker: UIPickerView!
    @IBOutlet var bbtnComplete: UIBarButtonItem!

    var delegate : CountSlideDelegate?
    var option : String!
    var touchOption = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            performSegue(withIdentifier: select, sender: self)
        }else{
            if delegate != nil{
                delegate?.didChangeOption(self, touch: touchOption)
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgCountDown"{
            let countdownController = segue.destination as! CountDownViewController
            countdownController.modalPresentationStyle = .fullScreen
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
            touchOption = true
            break;
        case 1:
            option = "sgCountDown"
            break;
        case 2:
            touchOption = false
            break;
        default:
            break;
        }
    }
}

