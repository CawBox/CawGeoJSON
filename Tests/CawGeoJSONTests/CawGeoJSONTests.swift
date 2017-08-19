import XCTest
@testable import Geometry

class CawGeoJSONTests: XCTestCase {
    func testPoint () {
        let point: [String: Any] = [
            "type": "Feature",
            "geometry": [
                "type": "Point",
                "coordinates": [102, 0.5]
            ]
        ]

        do {
            let feature = try Feature (json: point)
            XCTAssert (feature.geometry as? Geometry.Point != nil, "Geometry was supposed to be a point")
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testLineString () {
        let lineString: [String: Any] = [
         "type": "Feature",
            "geometry": [
                "type": "LineString",
                "coordinates": [
                [102.0, 0.0], [103.0, 1.0], [104.0, 0.0], [105.0, 1.0]
                ]
            ]
        ]

        do {
            let feature = try Feature (json: lineString)
            XCTAssert (feature.geometry as? Geometry.LineString != nil, "Geometry was supposed to be a linestring")
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testSimplePolygon () {
        let polygon: [String: Any] = [
            "type": "Feature",
            "geometry": [
                "type": "Polygon",
                "coordinates": [
                    [[30, 10], [40, 40], [20, 40], [10, 20], [30, 10]]
                ]
            ]
        ]

        do {
            let feature = try Feature (json: polygon)
            guard let polygon = feature.geometry as? Geometry.Polygon else {
                XCTFail("Geometry was supposed to be a polygon")
                return
            }

            XCTAssert(polygon.outerCoordinates.count == 5, "Polygon should have 5 outer points")
            XCTAssert(polygon.innerCoordinates.count == 0, "Polygon should have 0 inner points")
        } catch let error {
            XCTFail("\(error)")
        }
    }

    func testComplexPolygon () {
        let polygon: [String: Any] = [
            "type": "Feature",
            "geometry": [
                "type": "Polygon",
                "coordinates": [
                    [[35, 10], [45, 45], [15, 40], [10, 20], [35, 10]],
                    [[20, 30], [35, 35], [30, 20], [20, 30]]
                ]
            ]
        ]

        do {
            let feature = try Feature (json: polygon)
            guard let polygon = feature.geometry as? Geometry.Polygon else {
                XCTFail("Geometry was supposed to be a polygon")
                return
            }

            XCTAssert(polygon.outerCoordinates.count == 5, "Polygon should have 5 outer points")
            XCTAssert(polygon.innerCoordinates.count == 4, "Polygon should have 4 inner points")
        } catch let error {
            XCTFail("\(error)")
        }
    }

    static var allTests = [
        ("testPoint", testPoint),
        ("testLineString", testLineString),
        ("testSimplePolygon", testSimplePolygon),
        ("testComplexPolygon", testComplexPolygon),
        ]
}
