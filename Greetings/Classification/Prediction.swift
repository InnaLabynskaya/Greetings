//
//  Prediction.swift
//  Greetings
//
//  Created by Inna Kuts on 2/24/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import UIKit

/// Types of a prediction result.
enum Prediction {
    
    /// Healthy lunch.
    case healthy
    
    /// Fast food lunch.
    case fastFood
    
    /// Classification has failed with an error.
    case failed(Error?)
    
    /// Prediction result is empty.
    case empty
    
    /// Initializes the prediction enum with result returned from a ML model.
    ///
    /// - Parameter classLabel: The identifier returned by a model.
    init?(classLabel: String) {
        switch classLabel {
        case "fast food":
            self = .fastFood
        case "healthy":
            self = .healthy
        default:
            return nil
        }
    }
    
    /// The description of a prediction used for showing the information to the user.
    var description: String {
        switch self {
        case .healthy:
            return "HEALTHY 💪🏻"
        case .fastFood:
            return "FAST FOOD 😣"
        case .failed(let error):
            let text = "Unable to classify image 😔"
            guard let error = error else { return text }
            return text + ":\n" + error.localizedDescription
        case .empty:
            return "Nothing was recognized 😯"
        }
    }
    
    /// The color associated with prediction value.
    var color: UIColor {
        switch self {
        case .healthy:
            return #colorLiteral(red: 0.3371219039, green: 0.7178928256, blue: 0.09001944214, alpha: 1)
        case .fastFood:
            return #colorLiteral(red: 0.9815813899, green: 0.01640440524, blue: 0.2419521809, alpha: 1)
        case .failed(_), .empty:
            return .lightGray
        }
    }
}
