#!/usr/bin/env swift
//
//  EbayAnalytics App Icon Generator
//  Generates HIG-compliant module icon
//
//  Run: swift AppIconGenerator.swift
//

import Foundation
import AppKit

// MARK: - Analytics Icon Design
// Design: Chart/graph motif with upward trend
// Colors: Blue gradient (data/analytics theme)
// Symbol: Line chart with rising trend

struct IconColors {
    static let gradientStart = NSColor(red: 0.2, green: 0.5, blue: 0.95, alpha: 1.0)  // Bright blue
    static let gradientEnd = NSColor(red: 0.4, green: 0.3, blue: 0.9, alpha: 1.0)     // Purple-blue
    static let accent = NSColor.white
    static let chartLine = NSColor(red: 0.3, green: 0.85, blue: 0.6, alpha: 1.0)      // Success green
}

func drawIcon(size: CGFloat) -> NSImage {
    let image = NSImage(size: NSSize(width: size, height: size))
    
    image.lockFocus()
    
    let rect = NSRect(x: 0, y: 0, width: size, height: size)
    
    // Background gradient
    let gradient = NSGradient(starting: IconColors.gradientStart, ending: IconColors.gradientEnd)
    gradient?.draw(in: rect, angle: -45)
    
    let padding = size * 0.2
    let chartArea = NSRect(
        x: padding,
        y: padding,
        width: size - padding * 2,
        height: size - padding * 2
    )
    
    // Draw grid lines (subtle)
    let gridColor = NSColor(white: 1.0, alpha: 0.15)
    gridColor.setStroke()
    
    let gridPath = NSBezierPath()
    gridPath.lineWidth = size * 0.01
    
    // Horizontal grid lines
    for i in 0...3 {
        let y = chartArea.minY + chartArea.height * CGFloat(i) / 3
        gridPath.move(to: NSPoint(x: chartArea.minX, y: y))
        gridPath.line(to: NSPoint(x: chartArea.maxX, y: y))
    }
    gridPath.stroke()
    
    // Draw rising chart line
    let chartPath = NSBezierPath()
    chartPath.lineWidth = size * 0.04
    chartPath.lineCapStyle = .round
    chartPath.lineJoinStyle = .round
    
    // Data points (rising trend)
    let points: [(CGFloat, CGFloat)] = [
        (0.0, 0.2),
        (0.25, 0.35),
        (0.5, 0.3),
        (0.75, 0.6),
        (1.0, 0.85)
    ]
    
    for (i, point) in points.enumerated() {
        let x = chartArea.minX + chartArea.width * point.0
        let y = chartArea.minY + chartArea.height * point.1
        
        if i == 0 {
            chartPath.move(to: NSPoint(x: x, y: y))
        } else {
            chartPath.line(to: NSPoint(x: x, y: y))
        }
    }
    
    // Draw chart line with glow
    NSGraphicsContext.saveGraphicsState()
    let shadow = NSShadow()
    shadow.shadowOffset = NSSize(width: 0, height: 0)
    shadow.shadowBlurRadius = size * 0.03
    shadow.shadowColor = IconColors.chartLine.withAlphaComponent(0.5)
    shadow.set()
    
    IconColors.chartLine.setStroke()
    chartPath.stroke()
    NSGraphicsContext.restoreGraphicsState()
    
    // Draw data points
    IconColors.accent.setFill()
    for point in points {
        let x = chartArea.minX + chartArea.width * point.0
        let y = chartArea.minY + chartArea.height * point.1
        let dotSize = size * 0.05
        let dotRect = NSRect(x: x - dotSize/2, y: y - dotSize/2, width: dotSize, height: dotSize)
        NSBezierPath(ovalIn: dotRect).fill()
    }
    
    // Draw bar chart elements (background)
    let barColor = NSColor(white: 1.0, alpha: 0.25)
    barColor.setFill()
    
    let barWidth = chartArea.width * 0.12
    let barHeights: [CGFloat] = [0.4, 0.55, 0.45, 0.7, 0.9]
    
    for (i, height) in barHeights.enumerated() {
        let x = chartArea.minX + chartArea.width * CGFloat(i) / CGFloat(barHeights.count - 1) - barWidth/2
        let barHeight = chartArea.height * height * 0.6
        let barRect = NSRect(x: x, y: chartArea.minY, width: barWidth, height: barHeight)
        
        let barPath = NSBezierPath(roundedRect: barRect, xRadius: barWidth * 0.3, yRadius: barWidth * 0.3)
        barPath.fill()
    }
    
    image.unlockFocus()
    
    return image
}

func saveIcon(_ image: NSImage, to path: String) {
    guard let tiffData = image.tiffRepresentation,
          let bitmap = NSBitmapImageRep(data: tiffData),
          let pngData = bitmap.representation(using: .png, properties: [:]) else {
        print("Failed to create PNG")
        return
    }
    
    do {
        try pngData.write(to: URL(fileURLWithPath: path))
        print("✓ Generated: \(path)")
    } catch {
        print("✗ Failed: \(error)")
    }
}

// Generate icons
let sizes = [1024, 512, 256, 128, 64, 32]
let outputDir = "Icons"
try? FileManager.default.createDirectory(atPath: outputDir, withIntermediateDirectories: true)

for size in sizes {
    let image = drawIcon(size: CGFloat(size))
    saveIcon(image, to: "\(outputDir)/EbayAnalytics-\(size).png")
}

print("\n✅ EbayAnalytics icons generated in ./Icons/")
