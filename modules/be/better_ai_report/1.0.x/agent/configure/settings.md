<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Better AI Report

**Settings:** `better_ai_report.settings` → `/admin/config/better-ai-report/settings` (perm `administer better ai report`). Configure the AI provider, per-role allow/deny lists, row-scope filters, and the maximum row cap.

**Generate:** `better_ai_report.builder` → `/admin/reports/better-ai-report` (perm `generate better ai reports`). The user describes a report; `ConversationManager` + `AiChatClient` (via `@ai.provider`) produce a `ReportSpec`; `ReportGenerator` runs it.

**Security pipeline:** `SchemaContextBuilder` gives the model only allow-listed schema → `QueryGuard::validate(spec, scope)` enforces strict identifiers, scope membership, and base/joined-table-only references → `QueryBuilder`/`QueryExecutor` parameterize all values, read-only. `bypass better ai report row limit` lifts the cap. `ReportAuditLogger` records each run; `@flood` throttles generation.

**Export:** `better_ai_report.export_csv` (perm + `_csrf_token: TRUE`).
