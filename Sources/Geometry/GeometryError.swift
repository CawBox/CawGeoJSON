import Foundation

public enum GeometryError: Error {
    case unknownGeometryType (String)
    case missingRequiredProperty (String)
    case invalidProperty (String)
}
