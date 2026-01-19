# Tonguetoquill Static Analysis Report

[![github-repository](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/nibsbin/ttq-static-analysis-report)
[![typst-universe](https://img.shields.io/badge/Typst-Universe-aqua)](https://typst.app/universe/package/ttq-static-analysis-report)
[![nibs](https://img.shields.io/badge/author-Nibs-white?logo=github)](https://github.com/nibsbin)

A comprehensive static analysis security report template for Typst, designed for mobile and application security frameworks like MobSF.

Maintained by [TongueToQuill](https://www.tonguetoquill.com).

## Preview

<p align="center">
  <img src="thumbnail.png" alt="Report Template Preview" width="600">
</p>

See the [template](template/report.typ) for a complete working example report.

## Features

- **Executive Summary**: Security scorecard with color-coded severity ratings
- **Technical Metadata**: File, app, build, and binary information blocks
- **Security Analysis Tables**: Binary code analysis, security features, and protection status
- **Dependency Analysis**: Framework and library security scanning
- **Network Analysis**: Domain malware checks and geolocation tracking
- **Data Reconnaissance**: Sensitive data discovery (emails, URLs, API keys)
- **Audit Trail**: Detailed scan execution logs
- **Color-Coded Severity**: High (red), Warning (orange), Info (blue), Secure (green)

## Quick Start

**Using Typst CLI:**

```bash
typst init @preview/ttq-static-analysis-report:0.1.0
typst compile report.typ
```

**Using [typst.app](https://typst.app):**

Click "Start from template" and search for `ttq-static-analysis-report`.

## Components

### Report Header
```typst
#report-header(
  title: "MobSF",
  subtitle: "Mobile Security Framework - Static Analysis Report",
  metadata: (
    "File Name": "app.ipa",
    "Scan Date": "July 3, 2025",
  ),
)
```

### Security Scorecard
```typst
#scorecard(
  score: 44,
  risk-level: "MEDIUM",
  findings: (
    high: 12,
    warning: 18,
    info: 45,
    secure: 8,
  ),
)
```

### Security Table
```typst
#security-table(
  headers: ("No", "Issue", "Severity", "Description"),
  severity-column: 2,
  rows: (
    ("1", "Stack Canary Missing", "high", "Buffer overflow protection disabled"),
    ("2", "ARC Enabled", "secure", "Automatic Reference Counting active"),
  ),
)
```

### Metadata Block
```typst
#metadata-block(
  title: "File Information",
  data: (
    "File Name": "app.ipa",
    "File Size": "52.3 MB",
    "MD5": "a1b2c3d4...",
  ),
)
```

### Binary Analysis Table
```typst
#binary-table(
  entries: (
    (
      path: "Frameworks/libswift.dylib",
      nx: "secure",
      stack-canary: "secure",
      arc: "secure",
      code-signature: "secure",
    ),
  ),
)
```

### Domain Analysis
```typst
#domain-table(
  domains: (
    (
      url: "api.example.com",
      status: "OK",
      geolocation: (
        ip: "192.0.2.1",
        country: "United States",
        city: "San Francisco, CA",
      ),
    ),
  ),
)
```

### Log Table
```typst
#log-table(
  logs: (
    (
      timestamp: "2025-07-03 14:32:01",
      event: "Analysis started",
      status: "OK",
    ),
  ),
)
```

### Reconnaissance Table
```typst
#recon-table(
  title: "Emails Found",
  item-label: "Email",
  source-label: "Source File",
  items: (
    (
      value: "admin@example.com",
      source: "Main Binary",
    ),
  ),
)
```

## Documentation

For complete documentation and examples, see the [template](template/report.typ).

## Severity Levels

- **High**: Critical security flaws (red)
- **Warning**: Potential issues (orange)
- **Info**: Informational findings (blue)
- **Secure**: Security features present (green)
- **Hotspot**: Areas requiring attention (gray)

## License

MIT