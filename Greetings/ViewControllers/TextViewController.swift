//
//  TextViewController.swift
//  Greetings
//
//  Created by Inna Kuts on 2/24/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation
import UIKit
import NaturalLanguage

class TextViewController: UIViewController {
    
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var greetingsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greetingsTextField.delegate = self
    }
    
    @IBAction func checkGreetingsText(_ sender: Any) {
        predictGreetings()
    }
    
    private func predictGreetings() {
        predictionLabel.textColor = .lightGray
        guard let text = greetingsTextField.text, !text.isEmpty else {
            predictionLabel.text = "Text can not be empty 🤨"
            return
        }
        do {
            let model = try NLModel(mlModel: TextClassifier().model)
            guard let classLabel = model.predictedLabel(for: text) else {
                    return
            }
            predictionLabel.text = classLabel
        } catch {
            fatalError("Failed to load Text Classifier ML model: \(error)")
        }
    }
}

extension TextViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        greetingsTextField.resignFirstResponder()
        predictGreetings()
        return true
    }
}
