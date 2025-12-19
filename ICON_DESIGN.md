# EbayAnalytics Icon Design

## Design Concept

Analytics-themed icon featuring a rising line chart with data points, representing growth metrics and performance tracking.

## Visual Elements

- **Background**: Blue-to-purple gradient (-45°)
- **Chart Line**: Green rising trend line with glow effect
- **Data Points**: White dots at key positions
- **Bar Chart**: Semi-transparent white bars (background layer)
- **Grid**: Subtle horizontal lines

## Color Palette

```
Background Gradient:
  Start: #3380F2 (Bright Blue)
  End:   #664DE6 (Purple-Blue)

Chart Line: #4DD999 (Success Green)
Accents: #FFFFFF (White)
Grid: rgba(255, 255, 255, 0.15)
Bars: rgba(255, 255, 255, 0.25)
```

## HIG Compliance

| Requirement | Status |
|-------------|--------|
| Simple focal point | ✅ Rising chart line |
| Recognizable at small sizes | ✅ Bold strokes |
| Consistent with app theme | ✅ Matches Bazaar palette |
| No text | ✅ Symbol only |

## Generation

```bash
cd Bazaar/Packages/EbayAnalytics/Sources/Resources
swift AppIconGenerator.swift
```

## SF Symbol Alternative

Use `chart.line.uptrend.xyaxis` for a quick placeholder:

```swift
Image(systemName: "chart.line.uptrend.xyaxis")
    .font(.system(size: 60, weight: .medium))
    .foregroundStyle(.white)
    .frame(width: 120, height: 120)
    .background(
        LinearGradient(
            colors: [Color(hex: "3380F2"), Color(hex: "664DE6")],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
    .clipShape(RoundedRectangle(cornerRadius: 24))
```
