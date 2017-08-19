import Foundation

public struct Point {
    public let coordinate: (Double, Double)

    public init (coordinates: [Any]) throws {
        guard let pointCoordinates = coordinates as? [NSNumber],
            pointCoordinates.count == 2 else {
            throw GeometryError.invalidProperty ("Expected coordinates = [x, y]")
        }

        self.coordinate = (pointCoordinates[0].doubleValue, pointCoordinates[1].doubleValue)
    }
}

extension Point: GeometryProtocol {
}
