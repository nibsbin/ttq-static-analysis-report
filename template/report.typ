// Import the static analysis report template components
#import "../src/lib.typ": binary-table, data-table, domain-table, log-table, metadata-block, recon-table, report, report-header, scorecard, section-header, security-table, severity-badge

// Apply the report styling to the document
#show: report

// ========================================
// 1. COVER PAGE - MobSF BRANDED DESIGN
// ========================================

// Dark Hero Header
#block(
  width: 100%,
  height: 180pt,
  fill: rgb("#3E4149"),
  inset: 0pt,
  outset: (x: -0.6in, top: -0.6in),
  breakable: false,
  {
    place(center + horizon, {
      // Platform Icons
      align(center, {
        box(height: 18pt, baseline: 20%, image("../src/assets/solid/mobile-android.svg", height: 18pt))
        h(8pt)
        box(height: 18pt, baseline: 20%, image("../src/assets/solid/apple-whole.svg", height: 18pt))
        h(8pt)
        box(height: 18pt, baseline: 20%, image("../src/assets/solid/laptop.svg", height: 18pt))
      })

      v(12pt)

      // MobSF Logo Text
      text(size: 56pt, weight: "bold", fill: white, [M#text(fill: rgb("#CCCCCC"), [o])B#text(size: 56pt, weight: "bold", [SF])])

      v(8pt)

      // Subtitle
      text(size: 12pt, weight: "medium", fill: rgb("#D0D4D9"), tracking: 1pt, upper([IOS Static Analysis Report]))
    })
  }
)

#v(35pt)

// App Icon and Name
#align(center, {
  // App Icon Placeholder
  box(
    width: 80pt,
    height: 80pt,
    radius: 12pt,
    stroke: 1pt + rgb("#D0D4D9"),
    fill: white,
    align(center + horizon, text(size: 8pt, fill: rgb("#9CA3AF"), [APP ICON]))
  )

  v(12pt)

  // App Name
  text(size: 14pt, weight: "medium", fill: rgb("#1A1F28"), [🍎 SPOTLITE (1.0.5)])
})

#v(25pt)

// File Information Grid
#align(center, {
  block(
    width: 85%,
    {
      grid(
        columns: (auto, 1fr),
        row-gutter: 8pt,
        column-gutter: 15pt,
        align: (left, left),

        text(weight: "medium", fill: rgb("#4B5563"), size: 9.5pt, [File Name:]),
        text(fill: rgb("#2563EB"), size: 9.5pt, [SPOTLITE_v1.0.5.ipa]),

        text(weight: "medium", fill: rgb("#4B5563"), size: 9.5pt, [Identifier:]),
        text(fill: rgb("#2563EB"), size: 9.5pt, [com.example.spotlite]),

        text(weight: "medium", fill: rgb("#4B5563"), size: 9.5pt, [Scan Date:]),
        text(fill: rgb("#1A1F28"), size: 9.5pt, [July 3, 2025, 9:28 pm]),
      )
    }
  )
})

#v(25pt)

// Security Score
#align(center, {
  text(weight: "medium", fill: rgb("#4B5563"), size: 10pt, [App Security Score:])
  v(8pt)
  text(size: 32pt, weight: "bold", fill: rgb("#F59E0B"), [44/100 (MEDIUM RISK)])
})

#v(30pt)

// Divider
#line(length: 100%, stroke: 2pt + black)

#v(20pt)

// Grade Badge
#align(center, {
  text(weight: "medium", fill: rgb("#4B5563"), size: 10pt, [Grade:])
  v(10pt)
  box(
    width: 60pt,
    height: 60pt,
    fill: rgb("#EAB308"),
    radius: 4pt,
    align(center + horizon, text(size: 36pt, weight: "bold", fill: white, [B]))
  )
})

#pagebreak()

// ========================================
// 2. TECHNICAL SPECIFICATIONS (Pages 2-3)
// ========================================

#section-header("File Information", icon-name: "file-code")

#metadata-block(
  data: (
    "File Name": "SPOTLITE_v1.0.5.ipa",
    "File Size": "52.3 MB",
    "MD5": "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6",
    "SHA1": "1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0",
    "SHA256": "a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6q7r8s9t0u1v2w3x4y5z6a7b8c9d0e1f2",
  ),
)

#section-header("App Information", icon-name: "mobile-screen")

#metadata-block(
  data: (
    "App Name": "SPOTLITE",
    "App Type": "Swift",
    "Bundle Identifier": "com.example.spotlite",
    "Version": "1.0.5",
  ),
)

#section-header("Build & Platform Information", icon-name: "gear")

#metadata-block(
  data: (
    "SDK Name": "iphoneos",
    "SDK Version": "16.4",
    "Build Number": "1005",
    "Platform Version": "16.0",
    "Min OS Version": "14.0",
    "Supported Platforms": "iPhone, iPad",
  ),
)

#section-header("Binary Information", icon-name: "microchip")

#metadata-block(
  data: (
    "Architecture": "ARM64",
    "Sub Architecture": "ARM64E",
    "Bit": "64-bit",
    "Endianness": "Little Endian",
  ),
)

#pagebreak()

// ========================================
// 3. PRIMARY BINARY ANALYSIS (Pages 3-4)
// ========================================

#section-header("IPA Binary Code Analysis", icon-name: "bug")

#security-table(
  headers: ("Issue", "Severity", "Standards", "Description"),
  severity-column: 1,
  rows: (
    ("Insecure Random Function", "high", "CWE-330", "App uses insecure random number generation (rand, srand detected)"),
    ("Weak Crypto Algorithm", "high", "CWE-327", "MD5 hashing detected in binary"),
    ("SQL Injection Risk", "warning", "CWE-89", "Unsafe SQL query construction detected"),
    ("Hardcoded Encryption Key", "high", "CWE-321", "Potential hardcoded crypto key found"),
    ("Memory Corruption Risk", "warning", "CWE-119", "Unsafe buffer operations (strcpy, strcat) detected"),
    ("Information Disclosure", "info", "CWE-532", "NSLog statements present in production binary"),
  ),
)

#section-header("IPA Binary Analysis (Security Features)", icon-name: "shield")

#security-table(
  headers: ("Protection", "Status", "Severity", "Description"),
  severity-column: 2,
  rows: (
    ("NX (Non-Executable Stack)", "True", "secure", "Stack is marked non-executable, preventing code execution"),
    ("PIE (Position Independent Executable)", "True", "secure", "Binary compiled with PIE, enabling ASLR"),
    ("Stack Canary", "False", "high", "Stack smashing protection is NOT enabled"),
    ("ARC (Automatic Reference Counting)", "True", "secure", "Memory management uses ARC"),
    ("Code Signature", "True", "secure", "Binary is properly code signed"),
    ("Encryption", "False", "warning", "Binary encryption is NOT enabled"),
    ("Symbols Stripped", "False", "warning", "Debug symbols are present in binary"),
  ),
)

#pagebreak()

// ========================================
// 4. DEPENDENCY ANALYSIS (Pages 4-39)
// ========================================

#section-header("Framework & Library Analysis", icon-name: "cubes")

#text(size: 10pt, fill: rgb("#4B5563"), [This section analyzes all embedded frameworks and dynamic libraries. Below is a sample of key findings:])
#v(6pt)

#binary-table(
  entries: (
    (
      path: "Frameworks/libswiftCore.dylib",
      nx: "secure",
      stack-canary: "secure",
      arc: "secure",
      rpath: "secure",
      code-signature: "secure",
      encrypted: "info",
    ),
    (
      path: "Frameworks/libswiftFoundation.dylib",
      nx: "secure",
      stack-canary: "secure",
      arc: "secure",
      rpath: "secure",
      code-signature: "secure",
      encrypted: "info",
    ),
    (
      path: "Frameworks/Alamofire.framework/Alamofire",
      nx: "warning",
      stack-canary: "warning",
      arc: "secure",
      rpath: "secure",
      code-signature: "warning",
      encrypted: "secure",
    ),
    (
      path: "Frameworks/SDWebImage.framework/SDWebImage",
      nx: "info",
      stack-canary: "info",
      arc: "secure",
      rpath: "warning",
      code-signature: "secure",
      encrypted: "secure",
    ),
    (
      path: "Frameworks/Firebase.framework/Firebase",
      nx: "secure",
      stack-canary: "info",
      arc: "warning",
      rpath: "secure",
      code-signature: "secure",
      encrypted: "info",
    ),
    (
      path: "SPOTLITE (Main Binary)",
      nx: "secure",
      stack-canary: "high",
      arc: "secure",
      rpath: "info",
      code-signature: "secure",
      encrypted: "warning",
    ),
    (
      path: "Frameworks/Alamofire.framework",
      nx: "secure",
      stack-canary: "secure",
      arc: "secure",
      rpath: "secure",
      code-signature: "warning",
      encrypted: "secure",
    ),
  ),
)

#pagebreak()

// ========================================
// 5. NETWORK & DOMAIN ANALYSIS (Pages 39-42)
// ========================================

#section-header("Network Security Analysis", icon-name: "network-wired")

#block(
  width: 100%,
  inset: 12pt,
  stroke: 1.5pt + rgb("#DC2626"),
  fill: rgb("#FEF3C7"),
  radius: 3pt,
  [
    #box(height: 14pt, baseline: 17%, image("../src/assets/solid/triangle-exclamation.svg", height: 14pt))
    #h(7pt)
    #text(size: 11pt, weight: "bold", fill: rgb("#DC2626"), [WARNING: OFAC Sanctioned Countries])

    #v(5pt)

    This application communicates with domains located in or associated with OFAC sanctioned countries. This may violate compliance requirements.
  ]
)

#section-header("Domain Malware Check", icon-name: "globe")

#domain-table(
  domains: (
    (
      url: "api.spotlite.app",
      status: "OK",
      geolocation: (
        ip: "192.0.2.1",
        country: "United States",
        city: "San Francisco, CA",
      ),
    ),
    (
      url: "cdn.cloudflare.com",
      status: "OK",
      geolocation: (
        ip: "104.16.0.1",
        country: "United States",
        city: "San Francisco, CA",
      ),
    ),
    (
      url: "firebaseio.com",
      status: "OK",
      geolocation: (
        ip: "142.250.185.234",
        country: "United States",
        city: "Mountain View, CA",
      ),
    ),
    (
      url: "analytics.google.com",
      status: "OK",
      geolocation: (
        ip: "172.217.14.206",
        country: "United States",
        city: "Mountain View, CA",
      ),
    ),
    (
      url: "graph.facebook.com",
      status: "OK",
      geolocation: (
        ip: "157.240.2.35",
        country: "United States",
        city: "Menlo Park, CA",
      ),
    ),
  ),
)

#pagebreak()

// ========================================
// 6. DATA RECONNAISSANCE (Pages 42-43)
// ========================================

#section-header("Sensitive Data Discovery", icon-name: "magnifying-glass")

#recon-table(
  title: "Email Addresses Found",
  item-label: "Email",
  source-label: "Source File",
  icon-name: "envelope",
  items: (
    (
      value: "support@spotlite.app",
      source: "SPOTLITE (Main Binary)",
    ),
    (
      value: "admin@example.com",
      source: "Frameworks/AppConfig.framework",
    ),
    (
      value: "dev@spotlite.app",
      source: "SPOTLITE (Main Binary)",
    ),
  ),
)

#recon-table(
  title: "URLs Found",
  item-label: "URL",
  source-label: "Source File",
  icon-name: "link",
  items: (
    (
      value: "https://api.spotlite.app/v1/",
      source: "SPOTLITE (Main Binary)",
    ),
    (
      value: "https://cdn.spotlite.app/assets/",
      source: "SPOTLITE (Main Binary)",
    ),
    (
      value: "http://test.spotlite.internal/debug",
      source: "Frameworks/DebugTools.framework",
    ),
  ),
)

#recon-table(
  title: "API Keys & Secrets",
  item-label: "Type",
  source-label: "Location",
  icon-name: "key",
  items: (
    (
      value: "Firebase API Key (Partial): AIza*********************",
      source: "Info.plist",
    ),
    (
      value: "AWS Access Key ID Pattern Detected",
      source: "SPOTLITE (Main Binary)",
    ),
  ),
)

#pagebreak()

// ========================================
// 7. AUDIT TRAIL / SCAN LOGS (Pages 43-47)
// ========================================

#section-header("Scan Execution Log", icon-name: "clipboard-list")

#log-table(
  logs: (
    (
      timestamp: "2025-07-03 14:32:01",
      event: "Analysis started for SPOTLITE_v1.0.5.ipa",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:32:02",
      event: "Unzipping IPA archive",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:32:05",
      event: "Extracting Payload/SPOTLITE.app",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:32:06",
      event: "Parsing Info.plist",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:32:08",
      event: "Analyzing main binary executable",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:32:15",
      event: "Scanning for dangerous APIs",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:32:18",
      event: "Checking binary security features",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:32:20",
      event: "Analyzing embedded frameworks (47 found)",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:33:45",
      event: "Framework analysis completed",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:33:47",
      event: "Extracting network domains",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:33:50",
      event: "Performing domain malware check",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:33:55",
      event: "Scanning for sensitive data (emails, keys)",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:34:02",
      event: "Generating security score",
      status: "OK",
    ),
    (
      timestamp: "2025-07-03 14:34:05",
      event: "Report generation completed",
      status: "OK",
    ),
  ),
)

// ========================================
// 8. FOOTER
// ========================================

#v(1fr)

#align(center, {
  text(size: 8.5pt, fill: rgb("#6B7280"), [
    Report Generated by MobSF v3.8.0 • Mobile Security Framework

    © 2025 MobSF Project • https://github.com/MobSF/Mobile-Security-Framework-MobSF
  ])
})
