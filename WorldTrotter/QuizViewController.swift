//
//  QuizViewController.swift
//  WorldTrotter
//
//  Created by nigelli on 2023/4/8.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!

    let questions: [String] = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?",
    ]
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes",
    ]
    var curQuestionIdx: Int = 0

    @IBAction func showNextQuestion(_ sender: UIButton) {
        curQuestionIdx += 1
        if curQuestionIdx == questions.count {
            curQuestionIdx = 0
        }
        let question: String = questions[curQuestionIdx]
        questionLabel.text = question
        answerLabel.text = "???"
    }

    @IBAction func showAnswer(_ sender: UIButton) {
        let answer: String = answers[curQuestionIdx]
        answerLabel.text = answer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(type(of: self)) loaded its view.")
        questionLabel.text=questions[curQuestionIdx]
    }
}
