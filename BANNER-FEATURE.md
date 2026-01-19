# User-Defined Banner Feature

## Overview
The template now supports custom banner images that can be displayed at the top of reports.

## Usage

### In Components
Add a `banner` parameter to `report-header()`:

```typst
#report-header(
  title: "Security Analysis Report",
  subtitle: "Mobile Security Framework",
  banner: "../src/assets/banners/mobSF_banner.png",
  metadata: (
    "File": "example.ipa",
    "Date": "2025-07-03",
  ),
)
```

### Banner Location
Place banner images in: `src/assets/banners/`

### Supported Formats
- PNG
- JPG/JPEG
- SVG

### Recommended Dimensions
- Width: 1200-2400px
- Height: 200-400px
- Aspect ratio: 3:1 to 6:1

## Example: MobSF Banner

To use the MobSF banner in your report:

1. Save `mobSF_banner.png` to `src/assets/banners/`
2. Add to your report template:

```typst
#report-header(
  banner: "../src/assets/banners/mobSF_banner.png",
  // ... other parameters
)
```

## Implementation Details

The banner is rendered as a full-width block before the title in `report-header()`. If no banner is provided (`banner: none`), the component skips banner rendering and displays only the title and metadata.
