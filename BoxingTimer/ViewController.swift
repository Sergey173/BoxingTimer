//
//  ViewController.swift
//  BoxingTimer
//
//  Created by Sergey on 09.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var orangeStack: UIStackView!
    
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    
    // MARK: - Properties
    
    var roundsValueArray = ["1 раунд", "2 раунда", "3 раунда", "4 раунда", "5 раундов", "6 раундов", "7 раундов", "8 раундов", "9 раундов", "10 раундов", "11 раундов", "12 раундов", "13 раундов", "14 раундов", "15 раундов", "16 раундов"]
    var roundsTimeArray = [15, 30, 45, 60, 90, 5, 150, 180, 210, 240, 270, 300, 330, 360]
    var relaxationTimeArray = [15, 30, 45, 60, 90, 120, 150, 180]
    
    var _selectedRoundsValue:Int? = 5
    var _selectedRelaxionTime:Int? = 3
    var _selectedRoundsTime:Int? = 5
    
    var timer: Timer? = nil
    
    var selectedRelaxionTime:Int?{
        get{
            return _selectedRelaxionTime
        }
        set{
            _selectedRelaxionTime = newValue
            didselectedRelaxionTime_changed()
        }
    }
    var selectedRoundsTime:Int?{
        get{
            return _selectedRoundsTime
        }
        set{
            _selectedRoundsTime = newValue
            didselectedRoundsTime_changed()
        }
    }
    var selectedRoundsValue:Int?{
        get{
            return _selectedRoundsValue
        }
        set{
            _selectedRoundsValue = newValue
            didselectedRoundsValue_changed()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPickerView()
        setupOrangeStack(boolForStack: true)
    }
    
    //MARK: - Methods
    
    func didselectedRelaxionTime_changed(){
        thirdTextField.text = "Отдых \(selectedRelaxionTime!) секунд"
    }
    
    func didselectedRoundsTime_changed() {
        secondTextField.text = "Время раунда \(selectedRoundsTime!) секунд"
    }
    
    func didselectedRoundsValue_changed() {
        firstTextField.text = "\(selectedRoundsValue!) раундов"
    }
    
    func createTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateFirstTextView), userInfo: nil, repeats: true)
    }
    
    @objc func updateFirstTextView(){
        if let firstTextFieldText = firstTextField.text {
            if selectedRoundsValue == 1{
                timer?.invalidate()
            }
            selectedRoundsTime! -= 1
        }
        else if let secondTextFieldText = secondTextField.text{
            selectedRoundsValue! -= 1
        }
    }
    
    func setupPickerView(){
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(_selectedRelaxionTime!, inComponent: 0, animated: false)
        pickerView.selectRow(_selectedRoundsTime!, inComponent: 1, animated: false)
        pickerView.selectRow(_selectedRoundsValue!, inComponent: 2, animated: false)
    }
    
    func setupOrangeStack(boolForStack: Bool){
        orangeStack.isHidden = boolForStack
    }
    
    //MARK: - IBActions
    
    @IBAction func startButton(_ sender: Any) {
        orangeStack.backgroundColor = UIColor.orange
        setupOrangeStack(boolForStack: false)
        createTimer()
    }
    
}

//MARK: - Picker View Data Sourse, Picker View Delegate

extension ViewController:UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component{
        case 0:
            return relaxationTimeArray.count
        case 1:
            return roundsTimeArray.count
        default:
            return roundsValueArray.count;
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(relaxationTimeArray[row])+" секунд"
        case 1:
            return String(roundsTimeArray[row])+" секунд"
        default:
            return String(roundsValueArray[row]);
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedRelaxionTime = (relaxationTimeArray[row])
            thirdTextField.text = "\(selectedRelaxionTime!) секунд"
            didselectedRelaxionTime_changed()
            
        case 1:
            selectedRoundsTime = Int(roundsTimeArray[row])
            didselectedRoundsTime_changed()
        default:
            selectedRoundsValue = roundsValueArray.index(after: row)
            didselectedRoundsValue_changed()
            
        }
        
    }
    
}
