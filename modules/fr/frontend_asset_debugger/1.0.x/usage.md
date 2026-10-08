<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin reports that analyze frontend JS/CSS libraries for duplicates, unused libraries, render-blocking files, per-component usage, and a dependency graph.

---

Frontend Asset Debugger analyzes a site's declared asset libraries and reports duplicate files, unused libraries, render-blocking assets, per-component usage and an asset dependency graph, under Administration > Reports.

The `AssetAnalyzer` service inspects the library discovery, theme manager, module handler and theme extension list to build its reports; a separate `PageScanner` service can fetch a set of front-end URLs with the HTTP client to observe which libraries actually load on real pages, storing results in state. Report pages live under `/admin/reports/frontend-assets/*` (overview, duplicates, unused, render-blocking, per-component, dependency-graph, all) and are gated by `access frontend asset debugger` (not restricted — read-only reports). A settings form at `/admin/config/development/frontend-assets` and the scan actions require `administer frontend asset debugger` (restricted). Each report has a CSV/JSON export at `/export/{section}`.

Note: the page-scan HTTP client sets `verify => FALSE` (PageScanner.php:87); this is same-site fetching of public pages for an admin-only debug report with no credentials sent, so the disabled TLS check has no practical security impact here. Typical setup: enable the module, open the overview report, optionally run a page scan to enrich real-page usage data, and export findings.
---
- See an overview of all declared asset libraries.
- Find duplicate CSS/JS files shipped by multiple libraries.
- Identify libraries that are declared but never used.
- List render-blocking CSS/JS assets.
- Analyze which components pull in which assets.
- View an asset dependency graph.
- Browse the full list of all assets.
- Run a page scan to see which libraries load on real URLs.
- Export any report section to CSV/JSON.
- Configure module settings for scans.
- Audit theme vs module asset contributions.
- Track down unexpectedly heavy asset payloads.
- Prioritise assets to defer or aggregate.
- Grant read-only report access to developers.
- Restrict scan/settings actions to administrators.
- Diagnose why a library loads on a page.
- Compare declared libraries against actually-loaded ones.
- Feed findings into a performance-optimisation task.
