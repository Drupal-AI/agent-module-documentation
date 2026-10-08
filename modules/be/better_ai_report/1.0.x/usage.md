<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better AI Report lets trusted staff describe a report in natural language; the AI proposes a structured report specification, and the module builds parameterized, read-only queries constrained by per-role entity/table allow and deny lists.

The security boundary is deterministic and prompt-independent: `QueryGuard` validates the AI-produced `ReportSpec` against the acting user's `Scope`, requiring every table/column to match a strict `^[A-Za-z0-9_]+$` identifier pattern, to be in scope, and to be a declared base/joined table; `QueryBuilder`/`QueryExecutor` always parameterize values and only emit validated identifiers, so an injected or malicious prompt can at most produce a spec the guard rejects — it can never widen access. Row limits, row-scope filters, flood control, and audit logging apply. Results render in the builder at `/admin/reports/better-ai-report` and export to CSV (CSRF-protected). Three permissions separate configuration, generation (broad read of allow-listed data), and bypassing the row cap.

Use it to give analysts self-service, natural-language reporting over a curated slice of the database without handing them SQL or write access.
---
Generates safe, read-only reports from natural-language prompts using allow/deny-listed, parameterized queries.
---
- Ask for a report in plain language and get a table back
- Constrain reportable tables/columns per user role
- Enforce allow-list and deny-list of entities/tables
- Parameterize all query values to prevent SQL injection
- Reject out-of-scope or non-identifier table references
- Export a generated report to CSV (CSRF-protected)
- Cap report rows with a configurable maximum
- Grant "bypass better ai report row limit" to power users
- Flood-limit report generation per user
- Audit-log each report generation
- Configure the AI provider used for spec generation
- Scope reports to the current user's own rows
- Give analysts self-service reporting without SQL
- Refine a report through a conversation (spec enrichment)
- Keep all queries strictly read-only
- Separate config, generate, and bypass permissions
- Preview a report before exporting
- Build cross-table reports via validated joins
- Restrict provider/allow-list config to admins
- Provide human-readable formatting of result columns
