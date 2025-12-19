//
//  AppIconPreview.swift
//  EbayAnalytics
//
//  SwiftUI preview for the app icon in all variants
//

import SwiftUI

// MARK: - Icon Variant

public enum AppIconVariant: String, CaseIterable, Identifiable {
    case light = "Light"
    case dark = "Dark"
    case tinted = "Tinted"
    case sfSymbol = "SF Symbol"
    
    public var id: String { rawValue }
}

// MARK: - Color Palette

struct AppIconPalette {
    let gradientStart: Color
    let gradientEnd: Color
    let chartLine: Color
    let accent: Color
    let bars: Color
    let grid: Color
    
    static func palette(for variant: AppIconVariant) -> AppIconPalette {
        switch variant {
        case .light:
            return AppIconPalette(
                gradientStart: Color(red: 0.2, green: 0.5, blue: 0.95),
                gradientEnd: Color(red: 0.4, green: 0.3, blue: 0.9),
                chartLine: Color(red: 0.3, green: 0.85, blue: 0.6),
                accent: .white,
                bars: Color.white.opacity(0.25),
                grid: Color.white.opacity(0.15)
            )
        case .dark:
            return AppIconPalette(
                gradientStart: Color(red: 0.12, green: 0.35, blue: 0.75),
                gradientEnd: Color(red: 0.25, green: 0.18, blue: 0.7),
                chartLine: Color(red: 0.2, green: 0.7, blue: 0.5),
                accent: Color(white: 0.95),
                bars: Color.white.opacity(0.2),
                grid: Color.white.opacity(0.1)
            )
        case .tinted:
            return AppIconPalette(
                gradientStart: Color(white: 0.55),
                gradientEnd: Color(white: 0.45),
                chartLine: Color(white: 0.75),
                accent: .white,
                bars: Color.white.opacity(0.2),
                grid: Color.white.opacity(0.1)
            )
        case .sfSymbol:
            return AppIconPalette(
                gradientStart: .clear,
                gradientEnd: .clear,
                chartLine: Color.primary.opacity(0.85),
                accent: Color.primary.opacity(0.85),
                bars: Color.primary.opacity(0.15),
                grid: Color.primary.opacity(0.08)
            )
        }
    }
}

// MARK: - App Icon View

public struct AppIconView: View {
    let variant: AppIconVariant
    let size: CGFloat
    
    public init(variant: AppIconVariant = .light, size: CGFloat = 200) {
        self.variant = variant
        self.size = size
    }
    
    private var palette: AppIconPalette {
        AppIconPalette.palette(for: variant)
    }
    
    private var padding: CGFloat { size * (variant == .sfSymbol ? 0.1 : 0.18) }
    
    public var body: some View {
        Canvas { context, canvasSize in
            let rect = CGRect(origin: .zero, size: canvasSize)
            let chartArea = CGRect(
                x: padding,
                y: padding,
                width: canvasSize.width - padding * 2,
                height: canvasSize.height - padding * 2
            )
            
            // Background
            if variant != .sfSymbol {
                let gradient = Gradient(colors: [palette.gradientStart, palette.gradientEnd])
                context.fill(
                    Path(rect),
                    with: .linearGradient(
                        gradient,
                        startPoint: CGPoint(x: 0, y: canvasSize.height),
                        endPoint: CGPoint(x: canvasSize.width, y: 0)
                    )
                )
            }
            
            // Grid lines
            var gridPath = Path()
            for i in 0...3 {
                let y = chartArea.minY + chartArea.height * CGFloat(i) / 3
                gridPath.move(to: CGPoint(x: chartArea.minX, y: y))
                gridPath.addLine(to: CGPoint(x: chartArea.maxX, y: y))
            }
            context.stroke(gridPath, with: .color(palette.grid), lineWidth: max(1, size * 0.008))
            
            // Bar chart
            let barWidth = chartArea.width * 0.1
            let barHeights: [CGFloat] = [0.35, 0.5, 0.4, 0.65, 0.85]
            
            for (i, height) in barHeights.enumerated() {
                let x = chartArea.minX + chartArea.width * CGFloat(i) / CGFloat(barHeights.count - 1) - barWidth/2
                let barHeight = chartArea.height * height * 0.55
                let barRect = CGRect(x: x, y: chartArea.maxY - barHeight, width: barWidth, height: barHeight)
                let cornerRadius = max(1, barWidth * 0.25)
                context.fill(
                    Path(roundedRect: barRect, cornerRadius: cornerRadius),
                    with: .color(palette.bars)
                )
            }
            
            // Chart line
            let points: [(CGFloat, CGFloat)] = [
                (0.0, 0.2), (0.25, 0.38), (0.5, 0.32), (0.75, 0.62), (1.0, 0.88)
            ]
            
            var chartPath = Path()
            for (i, point) in points.enumerated() {
                let x = chartArea.minX + chartArea.width * point.0
                let y = chartArea.maxY - chartArea.height * point.1
                if i == 0 {
                    chartPath.move(to: CGPoint(x: x, y: y))
                } else {
                    chartPath.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            // Glow effect
            if variant != .sfSymbol {
                context.drawLayer { ctx in
                    ctx.addFilter(.blur(radius: size * 0.02))
                    ctx.stroke(chartPath, with: .color(palette.chartLine.opacity(0.6)), lineWidth: max(2, size * 0.04))
                }
            }
            
            // Main line
            context.stroke(
                chartPath,
                with: .color(palette.chartLine),
                style: StrokeStyle(lineWidth: max(2, size * 0.035), lineCap: .round, lineJoin: .round)
            )
            
            // Data points
            let dotSize = max(3, size * 0.045)
            for point in points {
                let x = chartArea.minX + chartArea.width * point.0
                let y = chartArea.maxY - chartArea.height * point.1
                let dotRect = CGRect(x: x - dotSize/2, y: y - dotSize/2, width: dotSize, height: dotSize)
                context.fill(Path(ellipseIn: dotRect), with: .color(palette.accent))
            }
            
            // Arrow indicator
            let arrowSize = size * 0.12
            let arrowX = chartArea.maxX - arrowSize * 0.3
            let arrowY = chartArea.minY + arrowSize * 0.5
            
            var arrowPath = Path()
            arrowPath.move(to: CGPoint(x: arrowX - arrowSize * 0.3, y: arrowY + arrowSize * 0.3))
            arrowPath.addLine(to: CGPoint(x: arrowX, y: arrowY))
            arrowPath.addLine(to: CGPoint(x: arrowX - arrowSize * 0.35, y: arrowY - arrowSize * 0.05))
            
            context.stroke(
                arrowPath,
                with: .color(palette.accent),
                style: StrokeStyle(lineWidth: max(2, size * 0.025), lineCap: .round, lineJoin: .round)
            )
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: size * 0.22, style: .continuous))
    }
}

// MARK: - Preview Gallery

public struct AppIconPreviewGallery: View {
    @State private var selectedVariant: AppIconVariant = .light
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 32) {
            // Large preview
            VStack(spacing: 12) {
                AppIconView(variant: selectedVariant, size: 200)
                    .shadow(color: .black.opacity(0.2), radius: 20, y: 10)
                
                Text(selectedVariant.rawValue)
                    .font(.headline)
            }
            
            // Variant picker
            Picker("Variant", selection: $selectedVariant) {
                ForEach(AppIconVariant.allCases) { variant in
                    Text(variant.rawValue).tag(variant)
                }
            }
            .pickerStyle(.segmented)
            .frame(maxWidth: 400)
            
            // All variants grid
            HStack(spacing: 24) {
                ForEach(AppIconVariant.allCases) { variant in
                    VStack(spacing: 8) {
                        AppIconView(variant: variant, size: 80)
                            .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                        
                        Text(variant.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .onTapGesture {
                        withAnimation { selectedVariant = variant }
                    }
                }
            }
            
            // Size variants
            VStack(alignment: .leading, spacing: 12) {
                Text("Size Variants")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 16) {
                    ForEach([16, 32, 64, 128], id: \.self) { size in
                        VStack(spacing: 4) {
                            AppIconView(variant: selectedVariant, size: CGFloat(size))
                            Text("\(size)pt")
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                    }
                }
            }
        }
        .padding(40)
        .background(Color(white: 0.95))
    }
}

// MARK: - Previews

#Preview("Icon Gallery") {
    AppIconPreviewGallery()
}

#Preview("Light") {
    AppIconView(variant: .light, size: 256)
        .padding()
}

#Preview("Dark") {
    AppIconView(variant: .dark, size: 256)
        .padding()
}

#Preview("Tinted") {
    AppIconView(variant: .tinted, size: 256)
        .padding()
}

#Preview("SF Symbol") {
    AppIconView(variant: .sfSymbol, size: 256)
        .padding()
}

#Preview("All Sizes") {
    HStack(spacing: 20) {
        ForEach([32, 64, 128, 256], id: \.self) { size in
            AppIconView(variant: .light, size: CGFloat(size))
        }
    }
    .padding()
}
