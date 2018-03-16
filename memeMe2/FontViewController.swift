//
//  FontViewController.swift
//  memeMe2
//
//  Created by Kyle Stokes on 3/12/18.
//  Copyright © 2018 Kyle Stokes. All rights reserved.
//

import UIKit

class FontViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var fontLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let fonts = ["Helvetica", "Arial", "Times New Roman", "Chalkboard SE"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fonts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        fontLabel.font = UIFont(name: fonts[row], size: 40.0)
        (UIApplication.shared.delegate as! AppDelegate).newFont = fontLabel.font
    }
    
    @IBAction func closePicker() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
