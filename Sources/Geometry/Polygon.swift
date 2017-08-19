import Foundation

public struct Polygon {
    public let outerCoordinates: [(Double, Double)]
    public let innerCoordinates: [(Double, Double)]

    public init (coordinates: [Any]) throws {
        func mapComponent (_ component: [[NSNumber]]) throws -> [(Double, Double)] {
            return try component
                .flatMap { item in
                    let values = item.flatMap { value in
                        return value.doubleValue
                    }

                    guard values.count == 2 else {
                        throw GeometryError.invalidProperty ("Expected coordinates = [[[x, y]], …]")
                    }

                    return (values [0], values [1])
            }
        }

        guard let components = coordinates as? [[Any]],
            components.count > 0 else {
                throw GeometryError.invalidProperty ("Expected coordinates = [[[x, y]], …]")
        }

        guard let outerComponent = components [0] as? [[NSNumber]] else {
            throw GeometryError.invalidProperty ("Expected coordinates = [[[x, y]], …]")
        }

        self.outerCoordinates = try mapComponent (outerComponent)

        if components.count > 1 {
            guard let innerComponent = components [1] as? [[NSNumber]] else {
                throw GeometryError.invalidProperty ("Expected coordinates = [[[x, y]], …]")
            }

            self.innerCoordinates = try mapComponent (innerComponent)
        } else {
            self.innerCoordinates = []
        }
    }
}

extension Polygon: GeometryProtocol {
}
