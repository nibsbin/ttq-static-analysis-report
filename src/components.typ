// components.typ
#import "layout.typ": config, vgap

// --- Utility Functions ---

// Horizontal Rule
#let hrule = {
  line(length: 100%, stroke: 0.75pt)
  v(-2pt)
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
  } else {
    black
  }
  
  text(fill: color, weight: "bold", upper(level))
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
    text(size: 24pt, weight: "bold", title)
    if subtitle != none {
      linebreak()
      text(size: 12pt, weight: "regular", subtitle)
    }
  })
  
  vgap(config.section-spacing)
  
  // App Icon (if provided)
  if app-icon != none {
    block(app-icon)
    vgap(config.entry-spacing)
  }
  
  set align(left)
  
  // Key Metadata Block
  if metadata.len() > 0 {
    vgap(config.section-spacing)
    block(
      width: 100%,
      inset: 10pt,
      stroke: config.table-stroke,
      fill: config.colors.bg-primary,
      {
        grid(
          columns: (auto, 1fr),
          row-gutter: 0.3em,
          column-gutter: 1em,
          ..metadata.pairs().map(((key, value)) => (
            text(weight: "bold", key + ":"),
            value,
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
    inset: 10pt,
    stroke: config.table-stroke,
    fill: config.colors.bg-primary,
    {
      // Score Display
      align(center, {
        text(size: 16pt, weight: "bold", "App Security Score")
        linebreak()
        text(size: 32pt, weight: "bold", str(score) + "/100")
        linebreak()
        severity-badge(risk-level.replace(" RISK", ""))
        text(" RISK")
      })
      
      vgap(config.entry-spacing)
      
      // Findings Summary Table
      if findings.len() > 0 {
        align(center, {
          text(weight: "bold", "Findings by Severity")
          vgap(0.3em)
          table(
            columns: findings.keys().len() + 1,
            stroke: config.table-stroke,
            align: center,
            [*Category*], ..findings.keys().map(k => text(weight: "bold", upper(k))),
            [*Count*], ..findings.values().map(v => str(v)),
          )
        })
      }
    }
  )
}

// Section Header
#let section-header(title, extra: none) = {
  vgap(config.section-spacing)
  set align(left)

  // Title
  block({
    text(size: 14pt, weight: "bold", upper(title))
    if extra != none {
      text(size: 14pt, weight: "bold", " " + extra)
    }
  })

  hrule
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
    inset: 8pt,
    stroke: config.table-stroke,
    fill: config.colors.bg-primary,
    {
      let items = data.pairs().map(((key, value)) => (
        text(weight: "bold", key + ":"),
        value,
      )).flatten()
      
      grid(
        columns: (auto, 1fr) * columns,
        row-gutter: 0.3em,
        column-gutter: 1em,
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
    text(weight: "bold", title)
    vgap(0.3em)
  }
  
  // Auto-numbering adds a "NO" column
  let final-headers = if auto-number {
    ([*NO*],) + headers.map(h => text(weight: "bold", h))
  } else {
    headers.map(h => text(weight: "bold", h))
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
    align: (col, row) => {
      if row == 0 { center } else { left }
    },
    fill: (col, row) => {
      if row == 0 { config.colors.bg-secondary } else if calc.rem(row, 2) == 0 { config.colors.bg-primary } else { white }
    },
    ..final-headers,
    ..final-rows,
  )
}

// Convenience wrappers for common table types (backward compatibility)

#let security-table(headers: (), rows: (), severity-column: none) = {
  data-table(
    headers: headers,
    rows: rows,
    severity-column: severity-column,
    auto-number: true,
  )
}

#let binary-table(entries: ()) = {
  data-table(
    headers: ([*DYLIB/FRAMEWORK*], [*NX*], [*STACK CANARY*], [*ARC*], [*RPATH*], [*CODE SIG*], [*ENCRYPTED*], [*SYMBOLS*]),
    columns: (auto, 1fr, auto, auto, auto, auto, auto, auto, auto),
    auto-number: true,
    rows: entries,
    transform: (entry, idx) => (
      text(size: 8pt, font: "Courier New", entry.path),
      entry.nx,
      entry.at("stack-canary"),
      entry.arc,
      entry.rpath,
      entry.at("code-signature"),
      entry.encrypted,
      entry.symbols,
    ),
    severity-column: none,  // All columns are severity-colored via transform
  )
}

#let domain-table(domains: ()) = {
  data-table(
    headers: ([*DOMAIN*], [*STATUS*], [*GEOLOCATION*]),
    columns: (auto, 2fr, auto, 3fr),
    auto-number: true,
    rows: domains,
    transform: (domain, idx) => (
      text(font: "Courier New", domain.url),
      domain.status,
      if "geolocation" in domain {
        let geo = domain.geolocation
        [IP: #geo.ip | Country: #geo.country | City: #geo.city]
      } else {
        [N/A]
      },
    ),
  )
}

#let log-table(logs: ()) = {
  data-table(
    headers: ([*TIMESTAMP*], [*EVENT*], [*STATUS*]),
    columns: (auto, 2fr, 4fr, auto),
    auto-number: true,
    rows: logs,
    transform: (log, idx) => (
      log.timestamp,
      log.event,
      if log.status == "OK" {
        text(fill: config.colors.secure, "OK")
      } else {
        text(fill: config.colors.high, log.status)
      },
    ),
  )
}

#let recon-table(title: "Discovered Items", items: (), item-label: "Item", source-label: "Source") = {
  data-table(
    title: title,
    headers: ([*#item-label*], [*#source-label*]),
    columns: (auto, 2fr, 3fr),
    auto-number: true,
    rows: items,
    transform: (item, idx) => (
      text(font: "Courier New", item.value),
      text(size: 8pt, item.source),
    ),
  )
}
