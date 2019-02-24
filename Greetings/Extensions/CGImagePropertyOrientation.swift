//
//  CGImagePropertyOrientation.swift
//  Greetings
//
//  Created by Inna Kuts on 2/24/19.
//  Copyright © 2019 Inna Kuts. All rights reserved.
//

import UIKit

extension CGImagePropertyOrientation {
    
    init(_ orientation: UIImage.Orientation) {
        switch orientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}
