import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct RateLimitsView: View {
    @StateObject private var viewModel = DeveloperAnalyticsViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else if viewModel.rateLimits.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "gauge")
                            .font(.system(size: 48))
                            .foregroundStyle(.secondary)
                        Text("No rate limit data")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.rateLimits) { limit in
                        RateLimitRow(limit: limit)
                    }
                }
            }
            .navigationTitle("API Rate Limits")
            .task {
                do {
                    try await viewModel.loadRateLimits()
                } catch {
                    // Error handled by viewModel
                }
            }
            .refreshable {
                do {
                    try await viewModel.loadRateLimits()
                } catch {
                    // Error handled by viewModel
                }
            }
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
struct RateLimitRow: View {
    let limit: RateLimit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(limit.apiName)
                .font(.headline)
            
            Text(limit.apiContext ?? "")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            if let remaining = limit.remaining, let total = limit.limit {
                RateLimitGauge(remaining: remaining, limit: total)
            }
        }
        .padding(.vertical, 4)
    }
}

@available(iOS 15.0, macOS 12.0, *)
struct RateLimitGauge: View {
    let remaining: Int
    let limit: Int
    
    var percentage: Double {
        guard limit > 0 else { return 0 }
        return Double(remaining) / Double(limit)
    }
    
    var color: Color {
        if percentage > 0.5 { return .green }
        if percentage > 0.2 { return .orange }
        return .red
    }
    
    var body: some View {
        HStack(spacing: 4) {
            Text("\(remaining)/\(limit)")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
        }
    }
}
