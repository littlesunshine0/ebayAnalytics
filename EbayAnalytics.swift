// EbayAnalytics.swift
// Main export file for EbayAnalytics
// Auto-generated - connects all package files

import SwiftUI
@_exported import HIGFoundation
@_exported import HIGComponents

// MARK: - EbayAnalytics Module

/// EbayAnalytics provides comprehensive functionality for the Ebay Developer API.
/// This module integrates with HIG (Human Interface Guidelines) components
/// for consistent, accessible, and platform-native user experiences.

// ═══════════════════════════════════════════════════════════════════════════════
// MARK: - Models
// ═══════════════════════════════════════════════════════════════════════════════
// Models: StandardsProfile AnalyticsData RateLimit

// ═══════════════════════════════════════════════════════════════════════════════
// MARK: - Views
// ═══════════════════════════════════════════════════════════════════════════════
// Views: AnalyticsView EmptyStateView RateLimitsView

// ═══════════════════════════════════════════════════════════════════════════════
// MARK: - ViewModels
// ═══════════════════════════════════════════════════════════════════════════════
// ViewModels: SellAnalyticsViewModel DeveloperAnalyticsViewModel

// ═══════════════════════════════════════════════════════════════════════════════
// MARK: - Services
// ═══════════════════════════════════════════════════════════════════════════════
// Services: SellAnalyticsService SellAnalyticsServiceProtocol DeveloperAnalyticsServiceProtocol DeveloperAnalyticsService

// ═══════════════════════════════════════════════════════════════════════════════
// MARK: - HIG Integration
// ═══════════════════════════════════════════════════════════════════════════════

/// HIG-compliant configuration for EbayAnalytics
public struct EbayAnalyticsHIGConfig {
    /// Shared configuration instance
    public static let shared = EbayAnalyticsHIGConfig()
    
    /// Whether to use HIG components
    public var useHIGComponents: Bool = true
    
    /// Whether to enforce accessibility
    public var enforceAccessibility: Bool = true
    
    /// Whether to respect reduce motion
    public var respectReduceMotion: Bool = true
    
    private init() {}
}
