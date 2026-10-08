<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better AI Report (better_ai_report) — agent index

**Natural-language, read-only reporting: AI proposes a spec, a deterministic guard + parameterized builder enforce per-role scope.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^10.4 || ^11 · **Depends on:** ai
- **Routes:** `better_ai_report.builder` `/admin/reports/better-ai-report` (perm `generate better ai reports`); `better_ai_report.export_csv` (perm + `_csrf_token`); `better_ai_report.settings` (perm `administer better ai report`)
- **Security core:** `Query/QueryGuard` validates the AI `ReportSpec` against `Access/Scope` — strict `^[A-Za-z0-9_]+$` identifiers, in-scope + declared tables only; `QueryBuilder`/`QueryExecutor` always parameterize values. Prompt injection can only yield a rejected spec, never widen access. Row caps, flood control, audit logging.
- **Permissions:** `administer better ai report`, `generate better ai reports`, `bypass better ai report row limit` (all restricted)
- **Security:** all routes permission-gated; CSV export CSRF-protected; queries strictly read-only and parameterized. No SQL concatenation of untrusted values found (PRAGMA path uses `escapeTable`).

See [configure/settings.md](configure/settings.md)
