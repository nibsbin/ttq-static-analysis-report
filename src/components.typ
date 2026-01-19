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
      fill: rgb("#F8F9FA"),
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
    fill: rgb("#F8F9FA"),
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
    fill: rgb("#FAFAFA"),
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

// Security Analysis Table
#let security-table(
  headers: (),
  rows: (),
  severity-column: none,
) = {
  vgap(config.entry-spacing)
  
  table(
    columns: headers.len(),
    stroke: config.table-stroke,
    align: (col, row) => {
      if row == 0 { center } else { left }
    },
    fill: (col, row) => {
      if row == 0 { rgb("#E9ECEF") } else if calc.rem(row, 2) == 0 { rgb("#F8F9FA") } else { white }
    },
    // Headers
    ..headers.map(h => text(weight: "bold", h)),
    // Rows
    ..rows.map(row => {
      row.enumerate().map(((i, cell)) => {
        if severity-column != none and i == severity-column {
          severity-badge(cell)
        } else {
          cell
        }
      })
    }).flatten()
  )
}

// Binary/Framework Analysis Table
#let binary-table(entries: ()) = {
  vgap(config.entry-spacing)
  
  if entries.len() == 0 { return }
  
  table(
    columns: (auto, 1fr, auto, auto, auto, auto, auto, auto, auto),
    stroke: config.table-stroke,
    align: (col, row) => {
      if row == 0 or col == 0 { center } else { left }
    },
    fill: (col, row) => {
      if row == 0 { rgb("#E9ECEF") } else if calc.rem(row, 2) == 0 { rgb("#F8F9FA") } else { white }
    },
    // Headers
    [*NO*], [*DYLIB/FRAMEWORK*], [*NX*], [*STACK CANARY*], [*ARC*], [*RPATH*], [*CODE SIG*], [*ENCRYPTED*], [*SYMBOLS*],
    // Data rows
    ..entries.enumerate().map(((idx, entry)) => (
      str(idx + 1),
      text(size: 8pt, font: "Courier New", entry.path),
      severity-badge(entry.nx),
      severity-badge(entry.stack-canary),
      severity-badge(entry.arc),
      severity-badge(entry.rpath),
      severity-badge(entry.code-signature),
      severity-badge(entry.encrypted),
      severity-badge(entry.symbols),
    )).flatten()
  )
}

// Domain/Network Analysis Table
#let domain-table(domains: ()) = {
  vgap(config.entry-spacing)
  
  if domains.len() == 0 { return }
  
  table(
    columns: (auto, 2fr, auto, 3fr),
    stroke: config.table-stroke,
    align: (col, row) => {
      if row == 0 { center } else { left }
    },
    fill: (col, row) => {
      if row == 0 { rgb("#E9ECEF") } else if calc.rem(row, 2) == 0 { rgb("#F8F9FA") } else { white }
    },
    [*NO*], [*DOMAIN*], [*STATUS*], [*GEOLOCATION*],
    ..domains.enumerate().map(((idx, domain)) => (
      str(idx + 1),
      text(font: "Courier New", domain.url),
      domain.status,
      {
        if "geolocation" in domain {
          let geo = domain.geolocation
          [IP: #geo.ip | Country: #geo.country | City: #geo.city]
        } else {
          [N/A]
        }
      },
    )).flatten()
  )
}

// Audit Log Table
#let log-table(logs: ()) = {
  vgap(config.entry-spacing)
  
  if logs.len() == 0 { return }
  
  table(
    columns: (auto, 2fr, 4fr, auto),
    stroke: config.table-stroke,
    align: (col, row) => {
      if row == 0 { center } else { left }
    },
    fill: (col, row) => {
      if row == 0 { rgb("#E9ECEF") } else if calc.rem(row, 2) == 0 { rgb("#F8F9FA") } else { white }
    },
    [*NO*], [*TIMESTAMP*], [*EVENT*], [*STATUS*],
    ..logs.enumerate().map(((idx, log)) => (
      str(idx + 1),
      log.timestamp,
      log.event,
      if log.status == "OK" { text(fill: config.colors.secure, "OK") } else { text(fill: config.colors.high, log.status) },
    )).flatten()
  )
}

// Reconnaissance Data Table (emails, URLs, etc.)
#let recon-table(title: "Discovered Items", items: (), item-label: "Item", source-label: "Source") = {
  vgap(config.entry-spacing)
  
  if items.len() == 0 { return }
  
  text(weight: "bold", title)
  vgap(0.3em)
  
  table(
    columns: (auto, 2fr, 3fr),
    stroke: config.table-stroke,
    align: (col, row) => {
      if row == 0 { center } else { left }
    },
    fill: (col, row) => {
      if row == 0 { rgb("#E9ECEF") } else if calc.rem(row, 2) == 0 { rgb("#F8F9FA") } else { white }
    },
    [*NO*], [*#item-label*], [*#source-label*],
    ..items.enumerate().map(((idx, item)) => (
      str(idx + 1),
      text(font: "Courier New", item.value),
      text(size: 8pt, item.source),
    )).flatten()
  )
}
