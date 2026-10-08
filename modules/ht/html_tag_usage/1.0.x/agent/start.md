<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTML Tag Usage (html_tag_usage) — agent index

**Scans formatted-text field content site-wide and reports which HTML tags/attributes are in use per text format, with per-entity drill-down.**

- **Version:** 1.0.x (1.0.0-beta5)
- **Core:** ^10.2 || ^11
- **Dependencies:** text
- **Configure:** `html_tag_usage.configure` — `/admin/config/development/html_tag_usage`
- **Routes:** `html_tag_usage.report` (view), `html_tag_usage.analyze` (generate, CSRF), `html_tag_usage.report.inspect` (dialog, CSRF), `html_tag_usage.configure`.
- **Permissions:** `view html tag usage report`, `generate html tag usage report`, `administer html tag usage`. Service `html_tag_usage.analyzer`; results in the `html_tag_usage` table.

**Security:** all routes permission-gated; the mutating `analyze` and the inspect dialog require a CSRF token; queries use the parameterized DB API. No security findings. (Operational note: results table can grow large — dev/staging tool.)

See [configure/html_tag_usage.md](configure/html_tag_usage.md) for the scan/report/inspect workflow.
