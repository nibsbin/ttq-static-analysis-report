// color-reference.typ
// Quick visual reference for the color palette
// Compile with: typst compile color-reference.typ pdfs/color-reference.pdf

#import "src/layout.typ": neutral, secondary, severity-colors

#set page(width: 8.5in, height: 11in, margin: 0.5in)
#set text(size: 10pt, font: "Arial")

#align(center)[
  = Color Palette Reference
  #text(size: 9pt, fill: gray)[Static Analysis Report Design System]
]

#v(1em)

// Color swatch helper
#let swatch(color, name, hex) = {
  grid(
    columns: (60pt, 1fr, 100pt),
    column-gutter: 10pt,
    align: (center + horizon, left + horizon, left + horizon),
    // Color box
    block(
      width: 50pt,
      height: 30pt,
      fill: color,
      stroke: 0.5pt + gray,
      radius: 3pt,
    ),
    // Name
    text(weight: "bold", name),
    // Hex value
    text(font: "Courier New", size: 9pt, hex),
  )
  v(0.5em)
}

// Section header
#let section(title) = {
  v(1em)
  block(
    width: 100%,
    inset: (left: 5pt, y: 5pt),
    fill: rgb("#E9ECEF"),
    stroke: (left: 3pt + rgb("#6C757D")),
    text(weight: "bold", size: 11pt, upper(title))
  )
  v(0.5em)
}

// Neutrals (60%)
#section("1. Neutrals — Foundation (60%)")

#text(size: 9pt, style: "italic")[Backgrounds, borders, and text hierarchy]
#v(0.5em)

#swatch(neutral.bg-dark, "Background Dark", "#1E1E2E")
#swatch(neutral.bg-darker, "Background Darker", "#181825")
#swatch(neutral.bg-card, "Background Card", "#252536")
#swatch(neutral.border, "Border", "#414558")
#swatch(neutral.divider, "Divider", "#313244")
#swatch(neutral.text-primary, "Text Primary", "#CDD6F4")
#swatch(neutral.text-secondary, "Text Secondary", "#A6ADC8")
#swatch(neutral.text-muted, "Text Muted", "#7F849C")

// Secondary UI (30%)
#section("2. Secondary UI — Interface (30%)")

#text(size: 9pt, style: "italic")[Table headers, surfaces, links]
#v(0.5em)

#swatch(secondary.surface, "Surface", "#313244")
#swatch(secondary.surface-hover, "Surface Hover", "#45475A")
#swatch(secondary.link, "Link", "#89B4FA")
#swatch(secondary.link-hover, "Link Hover", "#74C7EC")

// Severity/Status (10%)
#section("3. Severity & Status — Accents (10%)")

#text(size: 9pt, style: "italic")[Semantic colors for alerts, badges, and status indicators]
#v(0.5em)

#swatch(severity-colors.high, "High Severity", "#F38BA8")
#swatch(severity-colors.warning, "Warning", "#FAB387")
#swatch(severity-colors.info, "Info", "#89DCEB")
#swatch(severity-colors.secure, "Secure", "#A6E3A1")
#swatch(severity-colors.hotspot, "Hotspot", "#B4BEFE")
#swatch(severity-colors.caution, "Caution", "#F9E2AF")
#swatch(severity-colors.critical, "Critical", "#EBA0AC")

// Usage Examples
#section("Usage Examples")

#v(0.5em)
#grid(
  columns: (1fr, 1fr),
  column-gutter: 20pt,
  
  // Left column
  block(
    width: 100%,
    inset: 10pt,
    fill: neutral.bg-card,
    stroke: 0.5pt + neutral.border,
    radius: 4pt,
    {
      text(fill: neutral.text-primary, weight: "bold", "Card Component")
      linebreak()
      text(fill: neutral.text-secondary, size: 9pt, "Using neutral.bg-card background with border")
    }
  ),
  
  // Right column
  block(
    width: 100%,
    inset: 10pt,
    fill: severity-colors.high.lighten(85%),
    stroke: 1pt + severity-colors.high,
    radius: 4pt,
    {
      text(fill: severity-colors.high.darken(30%), weight: "bold", "⚠ High Alert")
      linebreak()
      text(size: 9pt, "Lightened background (85%) with border")
    }
  ),
)

#v(1em)

#block(
  width: 100%,
  inset: 10pt,
  fill: secondary.surface,
  stroke: 0.5pt + neutral.border,
  radius: 4pt,
  {
    text(fill: neutral.text-primary, weight: "bold", "Table Header Style")
    linebreak()
    text(fill: neutral.text-secondary, size: 9pt, "Using secondary.surface for headers")
  }
)

#v(2em)

// Footer
#align(center)[
  #text(size: 8pt, fill: gray)[
    See `DESIGN-SYSTEM.md` for detailed usage guidelines and best practices
  ]
]
