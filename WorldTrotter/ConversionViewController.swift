//
//  ViewController.swift
//  WorldTrotter
//
//  Created by nigelli on 2023/4/5.
//

import UIKit

class ConversionViewController: UIViewController {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(type(of: self)) loaded its view.")
        celsiusLabel.text = "???"
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
        if let text = textField.text, !text.isEmpty {
            celsiusLabel.text = textField.text
        } else {
            celsiusLabel.text = "???"
        }
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
}
