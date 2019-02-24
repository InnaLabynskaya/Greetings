//
//  ImageViewController.swift
//  Greetings
//
//  Created by Inna Kuts on 2/24/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import Foundation
import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    @IBOutlet weak var predictionView: UIView!
    
    /// Service for classification of images.
    private let classificationService = ImageClassificationService()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        classificationService.completionHandler = { [weak self] prediction in
            DispatchQueue.main.async {
                self?.updatePredictionLabel(with: prediction)
            }
        }
    }
    
    @IBAction func openPhoto(_ sender: Any) {
        present(imagePickerController, animated: true)
    }
    
    func updatePredictionLabel(with prediction: Prediction) {
        predictionLabel.text = prediction.description
        predictionLabel.textColor = prediction.color
    }
}

extension ImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        predictionLabel.text = "Classifying..."
        predictionLabel.textColor = .darkGray
        classificationService.predict(for: image)
    }
}
