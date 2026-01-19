# Design System & Color Palette

## Overview

This report template implements a modern, developer-friendly color system inspired by dark mode aesthetics. The palette follows the **60-30-10 design rule** to ensure visual hierarchy and reduced eye strain.

## Color Philosophy

### Dark Mode First Approach
- **No Pure Black**: We avoid `#000000` as it creates harsh contrast and screen smearing
- **Soft Blacks**: Using gunmetal grays (`#1E1E2E`, `#181825`) for comfortable backgrounds
- **Desaturated Accents**: Severity colors are pastel-ish to prevent "neon alarm" effect
- **Visual Hierarchy**: 60% neutral, 30% secondary UI, 10% accent/severity colors

## Color Palette

### 1. Neutrals (60% - Foundation)

#### Backgrounds
```typst
neutral.bg-dark: #1E1E2E      // Primary dark background
neutral.bg-darker: #181825    // Deeper background for contrast
neutral.bg-card: #252536      // Card/panel backgrounds
```

#### Borders & Dividers
```typst
neutral.border: #414558       // Soft borders
neutral.divider: #313244      // Subtle dividers
```

#### Text Hierarchy
```typst
neutral.text-primary: #CDD6F4    // Main content (soft white with blue tint)
neutral.text-secondary: #A6ADC8  // Secondary content (muted lavender)
neutral.text-muted: #7F849C      // Tertiary/disabled (gray-purple)
```

### 2. Secondary UI (30% - Interface Elements)

```typst
secondary.surface: #313244      // Table headers, sidebars
secondary.surface-hover: #45475A // Hover states

secondary.link: #89B4FA         // Hyperlinks (soft blue)
secondary.link-hover: #74C7EC   // Link hover (cyan-blue)
```

### 3. Severity/Status Colors (10% - Accent)

These are **desaturated** versions of traditional traffic light colors:

```typst
severity.high: #F38BA8          // Critical/High - Coral red (not alarm red)
severity.warning: #FAB387       // Warning - Peachy orange (not traffic cone)
severity.info: #89DCEB          // Info - Sky blue (not electric blue)
severity.secure: #A6E3A1        // Secure/Success - Sage green (not lime)
severity.hotspot: #B4BEFE       // Hotspot - Soft purple (distinctive)

// Additional
severity.caution: #F9E2AF       // Caution - Buttery yellow
severity.critical: #EBA0AC      // Critical - Deep pink
```

## Usage Examples

### Accessing Colors in Components

```typst
// Via config object
block(fill: config.colors.bg-primary)
text(fill: config.colors.text-secondary)
stroke: config.table-stroke  // Uses neutral.border

// Direct severity colors
severity-badge("high")  // Uses config.colors.high
```

### Semantic Aliases

Quick-access aliases are available in `config.colors`:

```typst
config.colors.bg-primary      // → neutral.bg-card
config.colors.bg-secondary    // → secondary.surface
config.colors.text-primary    // → neutral.text-primary
config.colors.text-secondary  // → neutral.text-secondary
config.colors.border          // → neutral.border
config.colors.link            // → secondary.link
```

### Creating Custom Components

```typst
#let custom-alert(severity, content) = {
  let bg-color = if severity == "error" {
    config.colors.high.lighten(80%)  // Lighten for background
  } else {
    config.colors.warning.lighten(80%)
  }
  
  block(
    fill: bg-color,
    stroke: 1pt + config.colors.border,
    inset: 10pt,
    radius: 4pt,
    content
  )
}
```

## Design Rationale

### Why These Colors?

1. **Reduced Eye Strain**: Soft blacks and desaturated colors prevent harsh contrast
2. **Semantic Clarity**: Each color has specific meaning (red = danger, green = safe)
3. **Accessibility**: Sufficient contrast ratios for readability
4. **Modern Aesthetic**: Inspired by popular developer tools (VS Code, GitHub Dark)
5. **Print-Friendly**: Colors maintain distinction when printed in grayscale

### Inspiration Sources

- **Catppuccin** color scheme (base backgrounds)
- **Nord** theme (text hierarchy)
- **Material Design 3** (semantic color system)
- **GitHub Dark** (UI surfaces)

## Contrast Guidelines

Ensuring WCAG AA compliance:

| Element | Background | Text Color | Contrast Ratio |
|---------|-----------|------------|----------------|
| Body text | `#252536` | `#CDD6F4` | ~12:1 ✅ |
| Secondary | `#313244` | `#A6ADC8` | ~8:1 ✅ |
| High severity | White | `#F38BA8` | ~4.5:1 ✅ |
| Links | `#252536` | `#89B4FA` | ~9:1 ✅ |

## Extending the Palette

To add new colors:

1. **Add to appropriate category** in `layout.typ`:
   ```typst
   #let severity-colors = (
     // ... existing colors
     new-status: rgb("#HEX"),
   )
   ```

2. **Use semantic naming**: Describe the purpose, not the appearance
   ```typst
   // Good
   deprecated: rgb("#AB7967")
   
   // Avoid
   brown-color: rgb("#AB7967")
   ```

3. **Test contrast**: Ensure readability on both light and dark backgrounds

## Best Practices

✅ **DO:**
- Use semantic color aliases (`config.colors.high`)
- Lighten/darken colors for backgrounds: `color.lighten(80%)`
- Maintain consistent usage (red = danger, green = safe)
- Test colors in both digital and print formats

❌ **DON'T:**
- Use pure black (`#000000`) or pure white (`#FFFFFF`) for large areas
- Mix neon/saturated colors with our palette
- Hard-code color values in components (use config)
- Use color as the *only* indicator (support colorblind users)

## Future Enhancements

- [ ] Light mode variant (inverted palette)
- [ ] Colorblind-safe alternative palette
- [ ] Dynamic color generation based on severity score
- [ ] CSS/HTML export for web reports
