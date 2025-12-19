import Foundation

public struct StandardsProfile: Identifiable, Codable, Sendable {
    public var id: String { program ?? UUID().uuidString }
    public let program: String?
    public let standardsLevel: String?
    public let cycle: StandardsCycle?
    
    public init(program: String? = nil, standardsLevel: String? = nil, cycle: StandardsCycle? = nil) {
        self.program = program
        self.standardsLevel = standardsLevel
        self.cycle = cycle
    }
}

public struct StandardsCycle: Codable, Sendable {
    public let cycleType: String?
    public let evaluationDate: String?
    
    public init(cycleType: String? = nil, evaluationDate: String? = nil) {
        self.cycleType = cycleType
        self.evaluationDate = evaluationDate
    }
}

public struct SellerStandardsProfile: Codable, Sendable {
    public let standardsProfiles: [StandardsProfile]?
    
    public init(standardsProfiles: [StandardsProfile]? = nil) {
        self.standardsProfiles = standardsProfiles
    }
}

public struct TrafficReport: Codable, Sendable {
    public let header: TrafficReportHeader?
    public let records: [TrafficReportRecord]?
    
    public init(header: TrafficReportHeader? = nil, records: [TrafficReportRecord]? = nil) {
        self.header = header
        self.records = records
    }
}

public struct TrafficReportHeader: Codable, Sendable {
    public let dimensionKeys: [String]?
    public let metricKeys: [String]?
    
    public init(dimensionKeys: [String]? = nil, metricKeys: [String]? = nil) {
        self.dimensionKeys = dimensionKeys
        self.metricKeys = metricKeys
    }
}

public struct TrafficReportRecord: Codable, Sendable {
    public let dimensionValues: [String]?
    public let metricValues: [String]?
    
    public init(dimensionValues: [String]? = nil, metricValues: [String]? = nil) {
        self.dimensionValues = dimensionValues
        self.metricValues = metricValues
    }
}

public struct CustomerServiceMetric: Codable, Sendable {
    public let customerServiceMetricCycles: [CustomerServiceMetricCycle]?
    
    public init(customerServiceMetricCycles: [CustomerServiceMetricCycle]? = nil) {
        self.customerServiceMetricCycles = customerServiceMetricCycles
    }
}

public struct CustomerServiceMetricCycle: Codable, Sendable {
    public let evaluationType: String?
    public let evaluationDate: String?
    
    public init(evaluationType: String? = nil, evaluationDate: String? = nil) {
        self.evaluationType = evaluationType
        self.evaluationDate = evaluationDate
    }
}
