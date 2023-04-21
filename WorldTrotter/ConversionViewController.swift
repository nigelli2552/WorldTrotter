//
//  ViewController.swift
//  WorldTrotter
//
//  Created by nigelli on 2023/4/5.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!

    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }

    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        return nil
    }

    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(type(of: self)) loaded its view.")
        updateCelsiusLabel()
        badMethod()
    }

    override func viewWillAppear(_ animated: Bool) {
//        let colors = [UIColor.systemRed,
//                      UIColor.systemBlue,
//                      UIColor.systemCyan,
//                      UIColor.systemPink,
//                      UIColor.systemPurple,
//                      UIColor.systemMint,
//                      UIColor.systemIndigo,
//        ]
//        let idx = Int.random(in: 0 ... colors.count - 1)
//        let color = colors[idx]
//        view.backgroundColor = color
    }

    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
//        if let text = textField.text, !text.isEmpty {
//            celsiusLabel.text = textField.text
//        } else {
//            celsiusLabel.text = "???"
//        }
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }

    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("Current text:\(String(describing: textField.text))")
//        print("Replacement text:\(string)")
        let current = Locale.current
        let decimalSeparator = current.decimalSeparator ?? "."
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        let replacementTextHasLetter = string.rangeOfCharacter(from: .letters)
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        }
        if replacementTextHasLetter != nil {
            return false
        }
        return true
    }

    func badMethod() {
        let array = NSMutableArray()
        for i in 0 ..< 10 {
            array.insert(i, at: i)
        }
        for _ in 0 ..< 10 {
            array.removeObject(at: 0)
        }
    }
}
