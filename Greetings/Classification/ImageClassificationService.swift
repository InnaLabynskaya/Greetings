//
//  ImageClassificationService.swift
//  Greetings
//
//  Created by Inna Kuts on 2/24/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import UIKit
import CoreML
import Vision

/// Service used for performing a classification of images by a ML model.
final class ImageClassificationService {
    
    /// Handler for returning classification result.
    var completionHandler: ((Prediction) -> ())?
    
    private lazy var classificationRequest: VNCoreMLRequest = {
        do {
            let model = try VNCoreMLModel(for: LunchImageClassifier().model)
            let request = VNCoreMLRequest(model: model, completionHandler: { [weak self] request, error in
                self?.handleClassifications(for: request, error: error)
            })
            request.imageCropAndScaleOption = .centerCrop
            return request
        } catch {
            fatalError("Failed to load Image Classifier ML model: \(error)")
        }
    }()
    
    /// Predict the result of image classification.
    ///
    /// - Parameter image: Image to classify.
    func predict(for image: UIImage) {
        let orientation = CGImagePropertyOrientation(image.imageOrientation)
        guard let ciImage = CIImage(image: image) else { fatalError("Unable to create \(CIImage.self) from \(image).") }
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(ciImage: ciImage, orientation: orientation)
            do {
                try handler.perform([self.classificationRequest])
            } catch {
                print("Failed to perform classification.\n\(error.localizedDescription)")
            }
        }
    }
    
    private func handleClassifications(for request: VNRequest, error: Error?) {
        guard let results = request.results else {
            completionHandler?(Prediction.failed(error))
            return
        }
        guard let classifications = results as? [VNClassificationObservation],
            let bestClassification = classifications.first,
            let prediction = Prediction(classLabel: bestClassification.identifier) else {
                completionHandler?(Prediction.empty)
                return
        }
        completionHandler?(prediction)
    }
}
