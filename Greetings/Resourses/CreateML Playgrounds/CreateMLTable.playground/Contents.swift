import CreateML
import Foundation

let dataPath = URL(fileURLWithPath: "Users/innakuts/Desktop/Table/PresentsTable.json")
let dataTable = try! MLDataTable(contentsOf: dataPath)

// Spliting the data into training and testing ones.
let (trainingData, testingData) = dataTable.randomSplit(by: 0.8, seed: 5)
// Initializing the classifier with a training data.
let classifier = try! MLClassifier(trainingData: trainingData, targetColumn: "name")

// Evaluating training & validation accuracies.
let trainingAccuracy = (1.0 - classifier.trainingMetrics.classificationError) * 100 // Result: 100%
let validationAccuracy = (1.0 - classifier.validationMetrics.classificationError) * 100 // Result: 200%

// Initializing the properly labeled testing data from Resources folder.
let evaluationMetrics = classifier.evaluation(on: testingData)
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100 // Result: 100%

// Confusion matrix in order to see which labels were classified wrongly.
let confusionMatrix = evaluationMetrics.confusion
print("Confusion matrix: \(confusionMatrix)")

// Metadata for saving the model.
let metadata = MLModelMetadata(author: "Inna Kuts",
                               shortDescription: "A model trained to classify best presents",
                               version: "1.0")
// Saving the model. Remember to update the path.
try classifier.write(to: URL(fileURLWithPath: "/Users/innakuts/Desktop/TableClassifier.mlmodel"),
                     metadata: metadata)
