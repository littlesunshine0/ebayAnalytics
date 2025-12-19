import XCTest
@testable import EbayAnalytics

final class EbayAnalyticsTests: XCTestCase {
    func testVersionExists() {
        XCTAssertFalse(EbayAnalytics.version.isEmpty)
    }
    
    func testAnalyticsPeriods() {
        XCTAssertEqual(AnalyticsPeriod.allCases.count, 5)
    }
    
    func testAnalyticsMetrics() {
        let metrics = AnalyticsMetrics(
            totalRequests: 1000,
            successRate: 0.95,
            averageResponseTime: 150,
            errorCount: 50
        )
        XCTAssertEqual(metrics.totalRequests, 1000)
        XCTAssertEqual(metrics.successRate, 0.95)
    }
}
