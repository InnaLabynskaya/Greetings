//
//  DataTableViewController.swift
//  Greetings
//
//  Created by Inna Kuts on 2/24/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation
import UIKit

class DataTableViewController: UIViewController {
    
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var forWhomTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [forWhomTextField, typeTextField, priceTextField].forEach({
            $0?.delegate = self
        })
    }
    
    @IBAction func checkPresentsDataTable(_ sender: Any) {
        predictPresent()
    }
    
    private func predictPresent() {
        predictionLabel.textColor = .lightGray
        guard let name = forWhomTextField.text, !name.isEmpty,
            let presentType = typeTextField.text, !presentType.isEmpty,
            let priceText = priceTextField.text, !priceText.isEmpty else {
                predictionLabel.text = "Data can not be empty 🤨"
                return
        }
        guard let price = Double(priceText) else {
            predictionLabel.text = "Price should include only numbers 🤨"
            return
        }
        let model = TableClassifier()
        do {
            let output = try model.prediction(name: name, price: price)
            let prediction = output.category
            predictionLabel.text = prediction
        } catch {
            predictionLabel.text = Prediction.failed(error).description
        }
    }
}

extension DataTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == forWhomTextField {
            typeTextField.becomeFirstResponder()
        }
        if textField == typeTextField {
            priceTextField.becomeFirstResponder()
        }
        if textField == priceTextField {
            priceTextField.resignFirstResponder()
            predictPresent()
        }
        return true
    }
}
