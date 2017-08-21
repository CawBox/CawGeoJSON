import Foundation

struct FeatureCollection {
    public let features: [Feature]

    init (json: [String: Any]) throws {
        guard let type = json [Keys.type.rawValue] as? String,
            type == "FeatureCollection" else {
                throw GeometryError.missingRequiredProperty (Keys.type.rawValue)
        }

        guard let features = json [Keys.features.rawValue] as? [[String: Any]] else {
            throw GeometryError.missingRequiredProperty (Keys.features.rawValue)
        }

        self.features = try features.flatMap { feature in
            return try Feature (json: feature)
        }
    }
}

extension FeatureCollection {
    enum Keys: String {
        case type
        case features
    }
}
