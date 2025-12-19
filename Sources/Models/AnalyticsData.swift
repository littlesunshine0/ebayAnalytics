import SwiftUI

// MARK: - Analytics Period
public enum AnalyticsPeriod: String, CaseIterable, Identifiable, Sendable {
    case today = "Today"
    case day = "Day"
    case week = "Week"
    case month = "Month"
    case quarter = "Quarter"
    case year = "Year"
    case custom = "Custom"
    
    public var id: String { rawValue }
    
    public var title: String {
        switch self {
        case .today: return "Today"
        case .day: return "Last 24 Hours"
        case .week: return "This Week"
        case .month: return "This Month"
        case .quarter: return "This Quarter"
        case .year: return "This Year"
        case .custom: return "Custom"
        }
    }
}

// MARK: - Chart Data Point
public struct ChartDataPoint: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let value: Double
    public let label: String
    public let date: Date?
    
    public init(id: UUID = UUID(), value: Double, label: String, date: Date? = nil) {
        self.id = id
        self.value = value
        self.label = label
        self.date = date
    }
    
    public init(date: Date, value: Double) {
        self.id = UUID()
        self.value = value
        self.label = ""
        self.date = date
    }
    
    public var formattedValue: String {
        if value >= 1000000 {
            return String(format: "$%.1fM", value / 1000000)
        } else if value >= 1000 {
            return String(format: "$%.1fK", value / 1000)
        }
        return String(format: "$%.0f", value)
    }
    
    public static let sampleWeek: [ChartDataPoint] = [
        ChartDataPoint(value: 1200, label: "Mon"),
        ChartDataPoint(value: 1800, label: "Tue"),
        ChartDataPoint(value: 1400, label: "Wed"),
        ChartDataPoint(value: 2200, label: "Thu"),
        ChartDataPoint(value: 1900, label: "Fri"),
        ChartDataPoint(value: 2800, label: "Sat"),
        ChartDataPoint(value: 2400, label: "Sun")
    ]
}

// MARK: - Analytics Data
public struct AnalyticsData: Identifiable, Equatable {
    public let id: UUID
    public let period: AnalyticsPeriod
    public let metrics: AnalyticsMetrics
    public let dataPoints: [DataPoint]
    
    public init(
        id: UUID = UUID(),
        period: AnalyticsPeriod,
        metrics: AnalyticsMetrics,
        dataPoints: [DataPoint]
    ) {
        self.id = id
        self.period = period
        self.metrics = metrics
        self.dataPoints = dataPoints
    }
}

// MARK: - Analytics Metrics
public struct AnalyticsMetrics: Equatable {
    public let totalRequests: Int
    public let successRate: Double
    public let averageResponseTime: Double
    public let errorCount: Int
    
    public init(
        totalRequests: Int,
        successRate: Double,
        averageResponseTime: Double,
        errorCount: Int
    ) {
        self.totalRequests = totalRequests
        self.successRate = successRate
        self.averageResponseTime = averageResponseTime
        self.errorCount = errorCount
    }
}

// MARK: - Data Point
public struct DataPoint: Identifiable, Equatable {
    public let id: UUID
    public let timestamp: Date
    public let value: Double
    public let label: String?
    
    public init(id: UUID = UUID(), timestamp: Date, value: Double, label: String? = nil) {
        self.id = id
        self.timestamp = timestamp
        self.value = value
        self.label = label
    }
}

// MARK: - Metric Type
public enum MetricType: String, CaseIterable, Identifiable, Sendable {
    case revenue = "Revenue"
    case orders = "Orders"
    case views = "Views"
    case impressions = "Impressions"
    
    public var id: String { rawValue }
}

// MARK: - Export Format
public enum ExportFormat: String, CaseIterable, Sendable {
    case csv = "CSV"
    case pdf = "PDF"
    case excel = "Excel"
}

// MARK: - Analytics Error
public enum AnalyticsError: LocalizedError {
    case fetchFailed(String)
    case exportFailed(String)
    
    public var errorDescription: String? {
        switch self {
        case .fetchFailed(let msg): return "Failed to load analytics: \(msg)"
        case .exportFailed(let msg): return "Failed to export report: \(msg)"
        }
    }
}

// MARK: - Seller Metrics
public struct SellerMetrics: Equatable, Sendable {
    public let totalRevenue: Double
    public let revenueChange: Double
    public let totalOrders: Int
    public let ordersChange: Double
    public let conversionRate: Double
    public let conversionChange: Double
    public let averageOrderValue: Double
    public let aovChange: Double
    
    public init(
        totalRevenue: Double,
        revenueChange: Double,
        totalOrders: Int,
        ordersChange: Double,
        conversionRate: Double,
        conversionChange: Double,
        averageOrderValue: Double,
        aovChange: Double
    ) {
        self.totalRevenue = totalRevenue
        self.revenueChange = revenueChange
        self.totalOrders = totalOrders
        self.ordersChange = ordersChange
        self.conversionRate = conversionRate
        self.conversionChange = conversionChange
        self.averageOrderValue = averageOrderValue
        self.aovChange = aovChange
    }
}

// MARK: - Sales Data Point
public struct SalesDataPoint: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let date: Date
    public let revenue: Double
    public let orders: Int
    
    public init(id: UUID = UUID(), date: Date, revenue: Double, orders: Int) {
        self.id = id
        self.date = date
        self.revenue = revenue
        self.orders = orders
    }
}

// MARK: - Traffic Data Point
public struct TrafficDataPoint: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let date: Date
    public let views: Int
    public let impressions: Int
    public let clicks: Int
    
    public init(id: UUID = UUID(), date: Date, views: Int, impressions: Int, clicks: Int) {
        self.id = id
        self.date = date
        self.views = views
        self.impressions = impressions
        self.clicks = clicks
    }
}

// MARK: - Analytics Summary
public struct AnalyticsSummary: Equatable, Sendable {
    public let totalRevenue: Double
    public let revenueChange: Double
    public let totalOrders: Int
    public let ordersChange: Double
    public let conversionRate: Double
    public let conversionChange: Double
    public let averageOrderValue: Double
    public let aovChange: Double
    
    public static let empty = AnalyticsSummary(
        totalRevenue: 0, revenueChange: 0,
        totalOrders: 0, ordersChange: 0,
        conversionRate: 0, conversionChange: 0,
        averageOrderValue: 0, aovChange: 0
    )
    
    public init(
        totalRevenue: Double,
        revenueChange: Double,
        totalOrders: Int,
        ordersChange: Double,
        conversionRate: Double,
        conversionChange: Double,
        averageOrderValue: Double,
        aovChange: Double
    ) {
        self.totalRevenue = totalRevenue
        self.revenueChange = revenueChange
        self.totalOrders = totalOrders
        self.ordersChange = ordersChange
        self.conversionRate = conversionRate
        self.conversionChange = conversionChange
        self.averageOrderValue = averageOrderValue
        self.aovChange = aovChange
    }
    
    public var formattedRevenue: String { "$\(String(format: "%.2f", totalRevenue))" }
    public var formattedAOV: String { "$\(String(format: "%.2f", averageOrderValue))" }
    public var formattedConversion: String { "\(String(format: "%.1f", conversionRate))%" }
}

// MARK: - Top Listing
public struct TopListing: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let title: String
    public let revenue: Double
    public let views: Int
    public let conversionRate: Double
    
    public init(id: UUID = UUID(), title: String, revenue: Double, views: Int, conversionRate: Double) {
        self.id = id
        self.title = title
        self.revenue = revenue
        self.views = views
        self.conversionRate = conversionRate
    }
}

// MARK: - Traffic Source
public struct TrafficSource: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let name: String
    public let visits: Int
    public let percentage: Double
    
    public init(id: UUID = UUID(), name: String, visits: Int, percentage: Double) {
        self.id = id
        self.name = name
        self.visits = visits
        self.percentage = percentage
    }
}
