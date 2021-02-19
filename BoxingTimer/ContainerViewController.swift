//
//  containerViewController.swift
//  BoxingTimer
//
//  Created by Sergey on 16.02.2021.
//

import UIKit

class containerViewController: UIViewController {
    
    var roundsValue = ["1 раунд", "2 раунда", "3 раунда", "4 раунда", "5 раундов", "6 раундов", "7 раундов", "8 раундов", "9 раундов", "10 раундов", "11 раундов", "12 раундов", "13 раундов", "14 раундов", "15 раундов", "16 раундов"]
    var roundsTime = [15, 30, 45, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330, 360]
    var relaxationTime = [15, 30, 45, 60, 90, 120, 150, 180]
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
    }
}

extension containerViewController:UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return relaxationTime.count
        case 1:
            return roundsTime.count
        default:
            return roundsValue.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(relaxationTime[row])+" секунд"
        case 1:
            return String(roundsTime[row])+" секунд"
        default:
            return String(roundsValue[row]);
        }
    }
    
    
}
