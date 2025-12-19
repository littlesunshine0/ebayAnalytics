# EbayAnalytics

Analytics module for the Bazaar marketplace app. Provides seller performance metrics, API rate limit monitoring, and developer analytics dashboards.

## Features

- **Seller Analytics** - Track sales performance, standards profiles, and seller metrics
- **Developer Analytics** - Monitor API usage and application performance
- **Rate Limits** - Real-time API rate limit tracking and alerts
- **HIG Compliant** - Built with Apple Human Interface Guidelines

## Installation

Add to your `Package.swift`:

```swift
.package(path: "../EbayAnalytics")
```

## Usage

```swift
import EbayAnalytics

// Display analytics dashboard
AnalyticsView()

// Monitor rate limits
RateLimitsView()
```

## Architecture

```
Sources/
├── Models/
│   ├── AnalyticsData.swift      # Core analytics data structures
│   ├── RateLimit.swift          # API rate limit models
│   └── StandardsProfile.swift   # Seller standards data
├── Views/
│   ├── AnalyticsView.swift      # Main analytics dashboard
│   ├── RateLimitsView.swift     # Rate limit monitoring
│   └── EmptyStateView.swift     # Empty state handling
├── ViewModels/
│   ├── SellAnalyticsViewModel.swift
│   └── DeveloperAnalyticsViewModel.swift
└── Services/
    ├── SellAnalyticsService.swift
    └── DeveloperAnalyticsService.swift
```

## Dependencies

- HIGFoundation
- HIGComponents
- EbayFoundation
- EbayAnimations
- EbayWidgetCards

## Requirements

- iOS 16+ / macOS 13+ / tvOS 16+ / watchOS 9+ / visionOS 1+
- Swift 5.9+
