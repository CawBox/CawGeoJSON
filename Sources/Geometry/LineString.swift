import Foundation

public struct LineString {
    public let coordinate: [(Double, Double)]

    public init (coordinates: [Any]) throws {
        guard let pointCoordinates = coordinates as? [[(NSNumber)]] else {
            throw GeometryError.invalidProperty ("Expected coordinates = [[x, y], …]")
        }

        self.coordinate = try pointCoordinates.flatMap { tuple in
            guard tuple.count == 2 else {
                throw GeometryError.invalidProperty ("Expected coordinates = [[x, y], …]")
            }

            return (tuple[0].doubleValue, tuple[1].doubleValue)
        }
    }
}

extension LineString: GeometryProtocol {
}
