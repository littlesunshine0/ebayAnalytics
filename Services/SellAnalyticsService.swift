import Foundation

public struct SellAnalyticsService: SellAnalyticsServiceProtocol {
    public init() {}
    
    public func getSellerStandardsProfile() async throws -> SellerStandardsProfile {
        SellerStandardsProfile(standardsProfiles: [
            StandardsProfile(program: "US", standardsLevel: "TOP_RATED"),
            StandardsProfile(program: "UK", standardsLevel: "ABOVE_STANDARD")
        ])
    }
    
    public func getTrafficReport(startDate: String, endDate: String) async throws -> TrafficReport {
        TrafficReport(
            header: TrafficReportHeader(dimensionKeys: ["date"], metricKeys: ["pageViews", "clicks"]),
            records: [
                TrafficReportRecord(dimensionValues: ["2024-12-01"], metricValues: ["1000", "50"]),
                TrafficReportRecord(dimensionValues: ["2024-12-02"], metricValues: ["1200", "60"])
            ]
        )
    }
    
    public func getCustomerServiceMetric(evaluationType: String) async throws -> CustomerServiceMetric {
        CustomerServiceMetric(customerServiceMetricCycles: [
            CustomerServiceMetricCycle(evaluationType: "CURRENT", evaluationDate: "2024-12-01")
        ])
    }
}
