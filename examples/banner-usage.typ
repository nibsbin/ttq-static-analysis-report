// Example: Using banner in report template
// This shows how to add a custom banner to your report

#import "../src/lib.typ": report, report-header

#show: report

// ========================================
// METHOD 1: Using report-header component with banner
// ========================================

#report-header(
  title: "MobSF",
  subtitle: "Mobile Security Framework - Static Analysis Report",
  banner: "../src/assets/banners/mobSF_banner.png",  // Add your banner here
  metadata: (
    "File Name": "SPOTLITE_v1.0.5.ipa",
    "App Identifier": "com.example.spotlite",
    "Scan Date": "July 3, 2025",
    "MobSF Version": "v3.8.0",
  ),
)

// ========================================
// METHOD 2: Custom banner in dark header block
// ========================================

// Add banner above the dark header
#image("../src/assets/banners/mobSF_banner.png", width: 100%)
#v(12pt)

// Then your existing dark header
#block(
  width: 100%,
  height: 180pt,
  fill: rgb("#3E4149"),
  // ... rest of header
)

// ========================================
// METHOD 3: Banner as page background
// ========================================

#page(
  background: place(
    top + center,
    image("../src/assets/banners/mobSF_banner.png", width: 100%)
  ),
  // ... content
)
