import Foundation

public struct Feature {
    public let geometry: GeometryProtocol

    init (json: [String: Any]) throws {
        guard let geometry = json [Keys.geometry.rawValue] as? [String: Any] else {
            throw GeometryError.missingRequiredProperty (Keys.geometry.rawValue)
        }

        guard let geometryType = geometry [Keys.type.rawValue] as? String else {
            throw GeometryError.missingRequiredProperty (Keys.type.rawValue)
        }

        guard let coordinates = geometry [Keys.coordinates.rawValue] as? [Any] else {
            throw GeometryError.missingRequiredProperty (Keys.coordinates.rawValue)
        }

        switch geometryType.lowercased () {
        case GeometryTypes.point.rawValue: self.geometry = try Point (coordinates: coordinates)
        case GeometryTypes.linestring.rawValue: self.geometry = try LineString (coordinates: coordinates)
        case GeometryTypes.polygon.rawValue: self.geometry = try Polygon (coordinates: coordinates)
        default: throw GeometryError.unknownGeometryType (geometryType)
        }
    }
}

extension Feature {
    enum Keys: String {
        case type
        case geometry
        case properties
        case coordinates
    }

    enum GeometryTypes: String {
        case point
        case linestring
        case polygon
    }
}
