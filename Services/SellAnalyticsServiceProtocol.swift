import Foundation

public protocol SellAnalyticsServiceProtocol: Sendable {
    func getSellerStandardsProfile() async throws -> SellerStandardsProfile
    func getTrafficReport(startDate: String, endDate: String) async throws -> TrafficReport
    func getCustomerServiceMetric(evaluationType: String) async throws -> CustomerServiceMetric
}
