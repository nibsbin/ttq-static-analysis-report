// layout.typ

// --- Light Mode Color Palette ---
// Clean, high-contrast design for maximum legibility
// Following 60-30-10 Rule: 60% Neutral, 30% Secondary, 10% Accent

// Core Palette (Neutrals - 60%)
#let neutral = (
  // Light backgrounds - clean whites and off-whites
  bg-dark: rgb("#FFFFFF"),      // Pure white for main background
  bg-darker: rgb("#F8F9FA"),    // Slightly off-white for subtle contrast
  bg-card: rgb("#F6F6F6"),      // Light gray for card/panel backgrounds

  // Grays for UI elements
  border: rgb("#D0D4D9"),       // Medium gray for borders
  divider: rgb("#E5E7EB"),      // Light gray for subtle dividers

  // Text hierarchy - dark colors for high contrast
  text-primary: rgb("#1A1F28"),    // Near-black for main text
  text-secondary: rgb("#4B5563"), // Medium gray for secondary text
  text-muted: rgb("#9CA3AF"),     // Light gray for tertiary/disabled text
)

// Secondary Palette (UI Elements - 30%)
#let secondary = (
  // Light grays for non-critical UI
  surface: rgb("#EBEEF1"),      // Table headers, sidebars
  surface-hover: rgb("#E5E7EB"), // Hover states

  // Blue for links and interactive elements
  link: rgb("#2563EB"),         // Strong blue for hyperlinks
  link-hover: rgb("#1D4ED8"),   // Darker blue on hover
)

// Accent Palette (Severity/Status - 10%)
// Saturated, clear colors for easy distinction
#let severity-colors = (
  // Critical/High - Strong red
  high: rgb("#DC2626"),         // Clear red for critical issues
  
  // Warning - Orange
  warning: rgb("#EA580C"),      // Distinct orange for warnings
  
  // Info - Blue
  info: rgb("#0284C7"),         // Clear blue for informational
  
  // Secure/Success - Green
  secure: rgb("#16A34A"),       // Strong green for success/secure
  
  // Hotspot/Neutral - Purple
  hotspot: rgb("#7C3AED"),      // Clear purple for hotspots
  
  // Additional semantic colors
  caution: rgb("#CA8A04"),      // Gold/amber for caution
  critical: rgb("#B91C1C"),     // Deep red for extreme cases
)

// --- Configurations ---
#let config = (
  font: "Arial",  // Changed to sans-serif for technical report readability
  base-size: 10.5pt,
  leading: 0.65em, // Global spacing value (vertical rhythm)
  section-spacing: 11pt,
  entry-spacing: 8pt,
  margin: 0.6in,
  table-stroke: 0.75pt + neutral.border,

  // Semantic color system
  colors: (
    // Severity/Status colors
    ..severity-colors,

    // Neutral colors for backgrounds and text
    neutral: neutral,

    // Secondary UI colors
    secondary: secondary,

    // Quick access semantic aliases
    bg-primary: neutral.bg-card,
    bg-secondary: secondary.surface,
    text-primary: neutral.text-primary,
    text-secondary: neutral.text-secondary,
    border: neutral.border,
    link: secondary.link,
  ),
)

// --- Utility Functions ---
#let vgap(amount) = v(amount)

// --- Report Show Rule (Global Setup) ---
#let report(content) = {
  set page(
    paper: "us-letter",
    margin: config.margin,
    numbering: "1 / 1",
    number-align: center + bottom,
  )

  set text(
    font: config.font,
    size: config.base-size,
    fill: config.colors.text-primary,
  )

  set par(
    leading: config.leading,
    justify: false,
    spacing: config.leading * 1.65, // Space between paragraphs
  )

  // Enforce global block spacing for vertical rhythm
  set block(above: config.leading * 1.2, below: config.leading * 1.2)
  set list(spacing: config.leading)

  // Hyperlinks should use semantic link color
  show link: it => text(fill: config.colors.link, underline(it))

  content
}
