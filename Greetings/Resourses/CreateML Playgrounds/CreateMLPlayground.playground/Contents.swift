import CreateMLUI
import CreateML
import Foundation

let trainDirectory = URL(fileURLWithPath: "/Users/innakuts/Downloads/Text")
let testDirectory = URL(fileURLWithPath: "/Users/innakuts/Downloads/Text testing")

let model = MLTextClassifier(trainingData: .labeledDirectories(at: trainDirectory))
let evaluation = model.evaluation(on: .labeledDirectories(at: testDirectory))

try model.write(to: URL(fileURLWithPath: "/Users/innakuts/Desktop/TextClassifier.mlmodel"))
