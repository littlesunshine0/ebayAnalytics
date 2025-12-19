import Foundation

public struct DeveloperAnalyticsService: DeveloperAnalyticsServiceProtocol {
    public init() {}
    
    public func getRateLimits() async throws -> RateLimitsResponse {
        RateLimitsResponse(rateLimits: [
            RateLimit(apiName: "Browse API", apiContext: "buy", limit: 5000, remaining: 4500, reset: "2024-12-20T00:00:00Z"),
            RateLimit(apiName: "Inventory API", apiContext: "sell", limit: 10000, remaining: 9800, reset: "2024-12-20T00:00:00Z"),
            RateLimit(apiName: "Fulfillment API", apiContext: "sell", limit: 5000, remaining: 4900, reset: "2024-12-20T00:00:00Z")
        ])
    }
    
    public func getUserRateLimits() async throws -> UserRateLimitsResponse {
        UserRateLimitsResponse(rateLimits: [
            UserRateLimit(apiName: "Browse API", apiContext: "buy", limit: 1000, remaining: 950, reset: "2024-12-20T00:00:00Z")
        ])
    }
}
