// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EbayAnalytics",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "EbayAnalytics", targets: ["EbayAnalytics"])
    ],
    dependencies: [
        .package(path: "../HIGFoundation"),
        .package(path: "../HIGComponents"),
        .package(path: "../EbayAnimations"),
        .package(path: "../EbayFoundation"),
        .package(path: "../EbayWidgetCards"),
    ],
    targets: [
        .target(
            name: "EbayAnalytics",
            dependencies: ["HIGFoundation", "HIGComponents", "EbayAnimations", "EbayFoundation", "EbayWidgetCards"],
            path: "Sources"
        ),
        .testTarget(
            name: "EbayAnalyticsTests",
            dependencies: ["EbayAnalytics"],
            path: "Tests"
        )
    ]
)
