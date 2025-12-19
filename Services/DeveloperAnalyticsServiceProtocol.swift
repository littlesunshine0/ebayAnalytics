import Foundation

public struct UserRateLimitsResponse: Codable, Sendable {
    public let rateLimits: [UserRateLimit]?
    
    public init(rateLimits: [UserRateLimit]? = nil) {
        self.rateLimits = rateLimits
    }
}

public protocol DeveloperAnalyticsServiceProtocol: Sendable {
    func getRateLimits() async throws -> RateLimitsResponse
    func getUserRateLimits() async throws -> UserRateLimitsResponse
}
