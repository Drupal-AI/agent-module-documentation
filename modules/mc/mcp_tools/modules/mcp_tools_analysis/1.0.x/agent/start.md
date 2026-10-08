<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Analysis (mcp_tools_analysis) — agent index

Submodule of **mcp_tools**. Adds **read-only** Tool API plugins for site-health and content
analysis — broken-link scan, SEO check, security audit, performance review, accessibility
check, content audit, duplicate detection, and unused-field detection — from an MCP/AI
connection. Package *MCP Tools*. Core `^10.3 || ^11 || ^12`. Depends on **mcp_tools** only.
No routes, forms, or config of its own.

- **The eight tools, inputs and what each analyzer inspects** →
  [tools/analysis-tools.md](tools/analysis-tools.md)

## What it provides

- Eight `tool` plugins in `src/Plugin/tool/Tool/`, all extending `McpToolsToolBase`
  (operation **Read**) with `MCP_CATEGORY = 'analysis'`: `FindBrokenLinks`
  (`mcp_analysis_broken_links`), `AnalyzeSeo` (`mcp_analysis_seo`), `SecurityAudit`
  (`mcp_analysis_security`), `AnalyzePerformance` (`mcp_analysis_performance`),
  `CheckAccessibility` (`mcp_analysis_accessibility`), `ContentAudit`
  (`mcp_analysis_content_audit`), `FindDuplicateContent` (`mcp_analysis_duplicates`),
  `FindUnusedFields` (`mcp_analysis_unused_fields`).
- Nine services in `src/Service/`: a facade `mcp_tools_analysis.analysis` (`AnalysisService`)
  plus eight specialized analyzers (`LinkAnalyzer`, `SeoAnalyzer`, `SecurityAuditor`,
  `PerformanceAnalyzer`, `AccessibilityAnalyzer`, `ContentAuditor`, `DuplicateDetector`,
  `FieldAnalyzer`).
- One permission: **`mcp_tools use analysis`** (`restrict access: true`).

## Access model (inherited)

All eight are **Read** operations, so `McpToolsToolBase::checkAccess()` requires only
`mcp_tools use analysis` + the **read** scope. No writes are performed. See
[tools/analysis-tools.md](tools/analysis-tools.md).

## Operate

```bash
drush en mcp_tools_analysis -y
```

`FindBrokenLinks` outbound fetching is disabled unless an `allowed_hosts` allowlist is set in
`mcp_tools.settings`. Grant `mcp_tools use analysis` to the executor role.
