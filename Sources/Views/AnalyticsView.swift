import SwiftUI

@available(iOS 15.0, macOS 12.0, *)
struct SellAnalyticsView: View {
    @StateObject private var viewModel = SellAnalyticsViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    List {
                        if let profile = viewModel.standardsProfile {
                            Section("Seller Standards") {
                                if let profiles = profile.standardsProfiles {
                                    ForEach(profiles) { standard in
                                        StandardsProfileRow(profile: standard)
                                    }
                                }
                            }
                        }
                        
                        if let metric = viewModel.customerServiceMetric {
                            Section("Customer Service") {
                                if let cycles = metric.customerServiceMetricCycles {
                                    ForEach(cycles, id: \.evaluationDate) { cycle in
                                        VStack(alignment: .leading) {
                                            Text(cycle.evaluationType ?? "")
                                                .font(.headline)
                                            Text(cycle.evaluationDate ?? "")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Seller Analytics")
            .task {
                await viewModel.loadStandardsProfile()
                await viewModel.loadCustomerServiceMetric()
            }
        }
    }
}

@available(iOS 15.0, macOS 12.0, *)
struct StandardsProfileRow: View {
    let profile: StandardsProfile
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(profile.program ?? "")
                    .font(.headline)
                Spacer()
                Text(profile.standardsLevel ?? "")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(levelColor.opacity(0.2))
                    .foregroundColor(levelColor)
                    .cornerRadius(4)
            }
        }
    }
    
    var levelColor: Color {
        switch profile.standardsLevel {
        case "TOP_RATED": return .green
        case "ABOVE_STANDARD": return .blue
        case "BELOW_STANDARD": return .red
        default: return .gray
        }
    }
}
