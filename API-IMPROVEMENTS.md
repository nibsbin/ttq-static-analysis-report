# API Improvements Summary

## Consolidation & Simplification

The report API has been refactored to improve ergonomics and reduce code duplication.

### Before: 4 Specialized Functions (Lots of Duplication)

```typst
// Each table had its own implementation with repeated styling logic
#security-table(headers: ..., rows: ..., severity-column: 2)
#binary-table(entries: ...)        // Hardcoded columns
#domain-table(domains: ...)         // Hardcoded columns  
#log-table(logs: ...)              // Hardcoded columns
#recon-table(items: ...)           // Different parameter style
```

### After: 1 Unified Core + Convenience Wrappers

```typst
// New flexible core function
#data-table(
  headers: ("Column1", "Column2"),
  rows: (("data1", "data2"), ...),
  auto-number: true,           // Auto-add "NO" column
  severity-column: 1,          // Highlight severity values
  title: "Custom Table Title", // Optional table title
  columns: (1fr, 2fr),        // Custom column widths
  transform: (row, idx) => ..., // Transform row data
)

// Backward-compatible convenience functions still work
#security-table(...)  // Same API as before
#binary-table(...)    // Same API as before
#domain-table(...)    // Same API as before
#log-table(...)       // Same API as before
#recon-table(...)     // Same API as before
```

## Key Benefits

### 1. **Reduced Code Duplication**
- ~150 lines → ~100 lines
- Single source of truth for table styling
- Easier to maintain and update styling globally

### 2. **Increased Flexibility**
Users can now create custom tables without writing new functions:

```typst
// Custom vulnerability table
#data-table(
  title: "Custom Vulnerabilities",
  headers: ("CVE", "Score", "Risk"),
  auto-number: true,
  severity-column: 2,  // Highlight the "Risk" column
  rows: (
    ("CVE-2024-1234", "9.8", "high"),
    ("CVE-2024-5678", "4.3", "warning"),
  ),
)
```

### 3. **Transform Function Power**
Process complex data structures without manual mapping:

```typst
#data-table(
  headers: ("Name", "Status"),
  auto-number: true,
  rows: api-response.results,
  transform: (item, idx) => (
    item.full-name.upper(),
    if item.active { "✓" } else { "✗" }
  ),
)
```

### 4. **Better Auto-Numbering**
- Automatically adjusts severity column index when numbering
- Consistent numbering behavior across all table types
- Can be toggled on/off per table

### 5. **Backward Compatible**
All existing code continues to work unchanged. The specialized functions now act as thin wrappers around `data-table`.

## Migration Guide

### No Changes Required
Existing templates work as-is. All original function signatures are preserved.

### Optional Enhancements
Take advantage of new features when needed:

```typst
// Old way (still works)
#security-table(
  headers: ("Issue", "Severity"),
  rows: (("Bug", "high"), ...),
  severity-column: 1,
)

// New way (more flexible)
#data-table(
  title: "Security Issues",
  headers: ("Issue", "Severity", "Remediation"),
  auto-number: true,
  severity-column: 1,
  columns: (2fr, 1fr, 3fr),
  rows: my-security-data,
)
```

## Code Reduction

- **Before**: 4 functions × ~40 lines each = ~160 lines
- **After**: 1 core function (60 lines) + 5 wrappers (10 lines each) = ~110 lines
- **Savings**: ~30% code reduction with increased functionality
