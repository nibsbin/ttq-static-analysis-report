// components.typ
#import "layout.typ": config, vgap

// --- Utility Functions ---

// Icon loader helper
#let icon(name, size: 12pt, fill: none) = {
  let icon-fill = if fill != none { fill } else { config.colors.text-primary }
  box(
    height: size,
    baseline: 17%,
    image("assets/solid/" + name + ".svg", height: size)
  )
}

// Horizontal Rule
#let hrule = {
  line(length: 100%, stroke: 1.25pt + config.colors.border)
}

// Severity Badge - Returns colored text based on severity level
#let severity-badge(level) = {
  let color = if level == "high" or level == "High" {
    config.colors.high
  } else if level == "warning" or level == "Warning" {
    config.colors.warning
  } else if level == "info" or level == "Info" {
    config.colors.info
  } else if level == "secure" or level == "Secure" {
    config.colors.secure
  } else if level == "hotspot" or level == "Hotspot" {
    config.colors.hotspot
  } else if level == "medium" or level == "Medium" {
    config.colors.warning
  } else {
    black
  }

  box(
    fill: color.lighten(87%),
    outset: (x: 6pt, y: 2.5pt),
    radius: 3pt,
    stroke: 1.1pt + color,
    text(fill: color, weight: "bold", size: 8.5pt, upper(level))
  )
}

// --- Component Exports ---

// Report Header with Branding
#let report-header(
  title: "Security Analysis Report",
  subtitle: none,
  app-name: "",
  app-icon: none,
  metadata: (:),
) = {
  set align(center)

  // Title/Branding
  block({
    text(size: 36pt, weight: "bold", fill: config.colors.text-primary, title)
    if subtitle != none {
      linebreak()
      v(8pt)
      text(size: 14pt, weight: "regular", fill: config.colors.text-secondary, subtitle)
    }
  })

  vgap(config.section-spacing * 2)

  // App Icon (if provided)
  if app-icon != none {
    block(app-icon)
    vgap(config.entry-spacing)
  }

  set align(left)

  // Key Metadata Block
  if metadata.len() > 0 {
    vgap(config.section-spacing * 2.5)
    block(
      width: 100%,
      inset: 18pt,
      radius: 4pt,
      stroke: 0.5pt + config.colors.border.lighten(20%),
      fill: config.colors.bg-primary,
      {
        grid(
          columns: (auto, 1fr),
          row-gutter: 0.75em,
          column-gutter: 2.5em,
          ..metadata.pairs().map(((key, value)) => (
            text(weight: "bold", fill: config.colors.text-primary, size: 10pt, key + ":"),
            text(fill: config.colors.text-primary, size: 10pt, value),
          )).flatten()
        )
      }
    )
  }
}

// Security Scorecard
#let scorecard(score: 0, risk-level: "UNKNOWN", findings: (:)) = {
  vgap(config.section-spacing)

  block(
    width: 100%,
    inset: 16pt,
    radius: 4pt,
    stroke: config.table-stroke,
    fill: config.colors.bg-primary,
    {
      // Score Display
      align(center, {
        icon("shield-halved", size: 22pt, fill: config.colors.text-primary)
        h(9pt)
        text(size: 18pt, weight: "bold", fill: config.colors.text-primary, "App Security Score")
        v(8pt)
        text(size: 46pt, weight: "bold", fill: config.colors.text-primary, str(score) + "/100")
        v(6pt)
        severity-badge(risk-level.replace(" RISK", ""))
        text(fill: config.colors.text-secondary, size: 10pt, weight: "medium", " RISK")
      })

      vgap(config.entry-spacing * 1.3)

      // Findings Summary Table
      if findings.len() > 0 {
        align(center, {
          text(size: 11.5pt, weight: "bold", fill: config.colors.text-primary, "Findings by Severity")
          vgap(0.6em)
          table(
            columns: findings.keys().len() + 1,
            stroke: 0.8pt + config.colors.border,
            align: center + horizon,
            inset: (x: 10pt, y: 6.5pt),
            fill: (col, row) => if row == 0 { config.colors.bg-secondary } else { none },
            [*Category*], ..findings.keys().map(k => text(weight: "bold", size: 9.5pt, upper(k))),
            [*Count*], ..findings.values().map(v => text(size: 10.5pt, weight: "medium", str(v))),
          )
        })
      }
    }
  )
}

// Section Header
#let section-header(title, extra: none, icon-name: none) = {
  vgap(config.section-spacing * 2)
  set align(left)

  // Title with optional icon
  block({
    if icon-name != none {
      icon(icon-name, size: 17pt, fill: config.colors.text-primary)
      h(9pt)
    }
    text(size: 16pt, weight: "bold", fill: config.colors.text-primary, upper(title))
    if extra != none {
      text(size: 16pt, weight: "bold", fill: config.colors.text-primary, " " + extra)
    }
  })
  v(4pt)
  hrule
  v(7pt)
}

// Key-Value Metadata Block
#let metadata-block(title: none, data: (:), columns: 1) = {
  vgap(config.entry-spacing)

  if title != none {
    text(weight: "bold", size: 11pt, title)
    vgap(0.3em)
  }

  block(
    width: 100%,
    inset: 13pt,
    radius: 4pt,
    stroke: 1pt + config.colors.border,
    fill: config.colors.bg-primary,
    {
      let items = data.pairs().map(((key, value)) => (
        text(weight: "bold", fill: config.colors.text-primary, size: 10pt, key + ":"),
        text(fill: config.colors.text-primary, size: 10pt, value),
      )).flatten()

      grid(
        columns: (auto, 1fr) * columns,
        row-gutter: 0.65em,
        column-gutter: 2em,
        ..items
      )
    }
  )
}

// Unified Data Table Component
// Flexible table with auto-numbering, severity highlighting, and customizable columns
#let data-table(
  headers: (),
  rows: (),
  columns: auto,  // Can be array of sizes or auto
  severity-column: none,
  auto-number: false,
  title: none,
  transform: none,  // Optional row transformation function
) = {
  vgap(config.entry-spacing)
  
  if rows.len() == 0 { return }
  
  // Add title if provided
  if title != none {
    text(weight: "bold", size: 11pt, fill: config.colors.text-primary, title)
    vgap(0.5em)
  }
  
  // Auto-numbering adds a "NO" column
  let final-headers = if auto-number {
    ([*NO*],) + headers.map(h => text(weight: "bold", size: 9.5pt, h))
  } else {
    headers.map(h => text(weight: "bold", size: 9.5pt, h))
  }
  
  // Adjust severity column index if auto-numbering
  let severity-idx = if severity-column != none and auto-number {
    severity-column + 1
  } else {
    severity-column
  }
  
  // Process rows
  let final-rows = rows.enumerate().map(((idx, row)) => {
    let processed-row = if transform != none {
      transform(row, idx)
    } else {
      row
    }
    
    // Add auto-number if enabled
    let numbered-row = if auto-number {
      (str(idx + 1),) + processed-row
    } else {
      processed-row
    }
    
    // Apply severity highlighting
    numbered-row.enumerate().map(((i, cell)) => {
      if severity-idx != none and i == severity-idx {
        severity-badge(cell)
      } else {
        cell
      }
    })
  }).flatten()
  
  table(
    columns: if columns == auto { final-headers.len() } else { columns },
    stroke: config.table-stroke,
    inset: (x: 8pt, y: 7.5pt),
    align: (col, row) => {
      if row == 0 { center + horizon } else { left + horizon }
    },
    fill: (col, row) => {
      if row == 0 {
        config.colors.bg-secondary
      } else if calc.rem(row, 2) == 0 {
        config.colors.bg-primary
      } else {
        none
      }
    },
    ..final-headers.map(h => text(weight: "bold", size: 10pt, h)),
    ..final-rows,
  )
}

// Convenience wrappers for common table types (backward compatibility)

#let security-table(headers: (), rows: (), severity-column: none) = {
  vgap(config.entry-spacing)

  if rows.len() == 0 { return }

  let final-headers = ([*NO*],) + headers.map(h => text(weight: "bold", size: 10pt, h))

  let severity-idx = if severity-column != none { severity-column + 1 } else { none }

  let final-rows = rows.enumerate().map(((idx, row)) => {
    let numbered-row = (str(idx + 1),) + row

    numbered-row.enumerate().map(((i, cell)) => {
      if severity-idx != none and i == severity-idx {
        severity-badge(cell)
      } else {
        cell
      }
    })
  }).flatten()

  table(
    columns: final-headers.len(),
    stroke: config.table-stroke,
    inset: (x: 8pt, y: 7pt),
    align: (col, row) => {
      if row == 0 { center + horizon } else { left + horizon }
    },
    fill: (col, row) => {
      if row == 0 {
        config.colors.bg-secondary
      } else if calc.rem(row, 2) == 0 {
        config.colors.bg-primary
      } else {
        none
      }
    },
    ..final-headers,
    ..final-rows,
  )
}

#let binary-table(entries: ()) = {
  vgap(config.entry-spacing)

  if entries.len() == 0 { return }

  let headers = (
    [*NO*],
    [*DYLIB/FRAMEWORK*],
    [*NX*],
    [*STACK#linebreak()CANARY*],
    [*ARC*],
    [*RPATH*],
    [*CODE#linebreak()SIG*],
    [*ENCRYPTED*]
  )

  let rows = entries.enumerate().map(((idx, entry)) => (
    str(idx + 1),
    text(size: 8.5pt, font: "Courier New", entry.path),
    severity-badge(entry.nx),
    severity-badge(entry.at("stack-canary")),
    severity-badge(entry.arc),
    severity-badge(entry.rpath),
    severity-badge(entry.at("code-signature")),
    severity-badge(entry.encrypted),
  )).flatten()

  table(
    columns: (auto, 2.8fr, 0.8fr, 0.9fr, 0.7fr, 0.8fr, 0.8fr, 0.9fr),
    stroke: config.table-stroke,
    inset: (x: 7pt, y: 7.5pt),
    align: (col, row) => {
      if col == 0 { center + horizon }
      else if row == 0 { center + horizon }
      else if col == 1 { left + horizon }
      else { center + horizon }
    },
    fill: (col, row) => {
      if row == 0 {
        config.colors.bg-secondary
      } else if calc.rem(row, 2) == 0 {
        config.colors.bg-primary
      } else {
        none
      }
    },
    ..headers,
    ..rows,
  )
}

#let domain-table(domains: ()) = {
  vgap(config.entry-spacing)

  if domains.len() == 0 { return }

  let headers = ([*NO*], [*DOMAIN*], [*STATUS*], [*GEOLOCATION*])

  let rows = domains.enumerate().map(((idx, domain)) => (
    str(idx + 1),
    text(font: "Courier New", size: 9pt, domain.url),
    text(size: 9pt, weight: "medium", fill: config.colors.secure, domain.status),
    if "geolocation" in domain {
      let geo = domain.geolocation
      text(size: 8.5pt, [IP: #geo.ip | Country: #geo.country | City: #geo.city])
    } else {
      text(size: 8.5pt, [N/A])
    },
  )).flatten()

  table(
    columns: (auto, 2fr, auto, 3fr),
    stroke: config.table-stroke,
    inset: (x: 8pt, y: 7.5pt),
    align: (col, row) => {
      if row == 0 { center + horizon }
      else if col == 0 or col == 2 { center + horizon }
      else { left + horizon }
    },
    fill: (col, row) => {
      if row == 0 {
        config.colors.bg-secondary
      } else if calc.rem(row, 2) == 0 {
        config.colors.bg-primary
      } else {
        none
      }
    },
    ..headers,
    ..rows,
  )
}

#let log-table(logs: ()) = {
  vgap(config.entry-spacing)

  if logs.len() == 0 { return }

  let headers = ([*NO*], [*TIMESTAMP*], [*EVENT*], [*STATUS*])

  let rows = logs.enumerate().map(((idx, log)) => (
    str(idx + 1),
    text(size: 9pt, log.timestamp),
    text(size: 9pt, log.event),
    if log.status == "OK" {
      text(fill: config.colors.secure, weight: "bold", size: 9pt, "OK")
    } else {
      text(fill: config.colors.high, weight: "bold", size: 9pt, log.status)
    },
  )).flatten()

  table(
    columns: (auto, 1.8fr, 3fr, auto),
    stroke: config.table-stroke,
    inset: (x: 8pt, y: 7.5pt),
    align: (col, row) => {
      if row == 0 { center + horizon }
      else if col == 0 or col == 3 { center + horizon }
      else { left + horizon }
    },
    fill: (col, row) => {
      if row == 0 {
        config.colors.bg-secondary
      } else if calc.rem(row, 2) == 0 {
        config.colors.bg-primary
      } else {
        none
      }
    },
    ..headers,
    ..rows,
  )
}

#let recon-table(title: "Discovered Items", items: (), item-label: "Item", source-label: "Source", icon-name: none) = {
  vgap(config.entry-spacing * 1.2)

  if title != none {
    block({
      if icon-name != none {
        icon(icon-name, size: 12pt, fill: config.colors.text-primary)
        h(7pt)
      }
      text(weight: "bold", size: 12pt, fill: config.colors.text-primary, title)
    })
    vgap(0.6em)
  }

  if items.len() == 0 { return }

  let headers = ([*NO*], [*#item-label*], [*#source-label*])

  let rows = items.enumerate().map(((idx, item)) => (
    str(idx + 1),
    text(font: "Courier New", size: 9pt, item.value),
    text(size: 9pt, item.source),
  )).flatten()

  table(
    columns: (auto, 2.5fr, 2fr),
    stroke: config.table-stroke,
    inset: (x: 8pt, y: 7.5pt),
    align: (col, row) => {
      if row == 0 { center + horizon }
      else if col == 0 { center + horizon }
      else { left + horizon }
    },
    fill: (col, row) => {
      if row == 0 {
        config.colors.bg-secondary
      } else if calc.rem(row, 2) == 0 {
        config.colors.bg-primary
      } else {
        none
      }
    },
    ..headers,
    ..rows,
  )
}
