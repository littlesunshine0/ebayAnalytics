import Foundation
import SwiftUI

@MainActor
final class DeveloperAnalyticsViewModel: ObservableObject {
    @Published var rateLimits: [RateLimit] = []
    @Published var userRateLimits: [UserRateLimit] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let service: DeveloperAnalyticsServiceProtocol
    
    init(service: DeveloperAnalyticsServiceProtocol = DeveloperAnalyticsService()) {
        self.service = service
    }
    
    func loadRateLimits() async throws {
        isLoading = true
        error = nil
        
        do {
            let response = try await service.getRateLimits()
            rateLimits = response.rateLimits ?? []
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func loadUserRateLimits() async throws {
        isLoading = true
        error = nil
        
        do {
            let response = try await service.getUserRateLimits()
            userRateLimits = response.rateLimits ?? []
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
