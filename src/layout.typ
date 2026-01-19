// layout.typ

// --- Severity Color Scheme ---
#let severity-colors = (
  high: rgb("#DC3545"),      // Red for critical/high severity
  warning: rgb("#FD7E14"),   // Orange for warnings
  info: rgb("#0D6EFD"),      // Blue for informational
  secure: rgb("#198754"),    // Green for secure/safe
  hotspot: rgb("#6C757D"),   // Gray for hotspots
)

// --- Configurations ---
#let config = (
  font: "Arial",  // Changed to sans-serif for technical report readability
  base-size: 10pt,
  leading: 0.5em, // Global spacing value (vertical rhythm)
  section-spacing: 8pt,
  entry-spacing: 6pt,
  margin: 0.5in,
  table-stroke: 0.5pt + gray,
  colors: severity-colors,
)

// --- Utility Functions ---
#let vgap(amount) = v(amount)

// --- Report Show Rule (Global Setup) ---
#let report(content) = {
  set page(
    paper: "us-letter",
    margin: config.margin,
    numbering: "1",
    number-align: center,
  )

  set text(
    font: config.font,
    size: config.base-size,
  )

  set par(
    leading: config.leading,
    justify: false,
    spacing: config.leading, // Space between paragraphs
  )

  // Enforce global block spacing for vertical rhythm
  set block(above: config.leading, below: config.leading)
  set list(spacing: config.leading)

  // Hyperlinks should be blue and underlined for reports
  show link: it => text(fill: blue, underline(it))

  content
}
