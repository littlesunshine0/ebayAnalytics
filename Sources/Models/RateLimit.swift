import Foundation

public struct RateLimit: Identifiable, Codable, Sendable {
    public var id: String { apiName }
    public let apiName: String
    public let apiContext: String?
    public let limit: Int?
    public let remaining: Int?
    public let reset: String?
    
    public init(
        apiName: String,
        apiContext: String? = nil,
        limit: Int? = nil,
        remaining: Int? = nil,
        reset: String? = nil
    ) {
        self.apiName = apiName
        self.apiContext = apiContext
        self.limit = limit
        self.remaining = remaining
        self.reset = reset
    }
}

public struct UserRateLimit: Identifiable, Codable, Sendable {
    public var id: String { apiName }
    public let apiName: String
    public let apiContext: String?
    public let limit: Int?
    public let remaining: Int?
    public let reset: String?
    
    public init(
        apiName: String,
        apiContext: String? = nil,
        limit: Int? = nil,
        remaining: Int? = nil,
        reset: String? = nil
    ) {
        self.apiName = apiName
        self.apiContext = apiContext
        self.limit = limit
        self.remaining = remaining
        self.reset = reset
    }
}

public struct RateLimitsResponse: Codable, Sendable {
    public let rateLimits: [RateLimit]?
    
    public init(rateLimits: [RateLimit]? = nil) {
        self.rateLimits = rateLimits
    }
}
