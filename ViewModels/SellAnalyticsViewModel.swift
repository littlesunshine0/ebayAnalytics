import Foundation
import SwiftUI

@MainActor
final class SellAnalyticsViewModel: ObservableObject {
    @Published var standardsProfile: SellerStandardsProfile?
    @Published var trafficReport: TrafficReport?
    @Published var customerServiceMetric: CustomerServiceMetric?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let service: SellAnalyticsServiceProtocol
    
    init(service: SellAnalyticsServiceProtocol = SellAnalyticsService()) {
        self.service = service
    }
    
    func loadStandardsProfile() async {
        isLoading = true
        error = nil
        
        do {
            standardsProfile = try await service.getSellerStandardsProfile()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func loadTrafficReport(startDate: String, endDate: String) async {
        isLoading = true
        error = nil
        
        do {
            trafficReport = try await service.getTrafficReport(startDate: startDate, endDate: endDate)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func loadCustomerServiceMetric(evaluationType: String = "CURRENT") async {
        isLoading = true
        error = nil
        
        do {
            customerServiceMetric = try await service.getCustomerServiceMetric(evaluationType: evaluationType)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
