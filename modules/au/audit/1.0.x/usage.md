Audit is a pluggable framework that scores Drupal site health across many dimensions and reports the results in the admin UI, via Drush JSON, and optionally to the DruScan portal.

---

The base `audit` module provides no checks itself; it defines an `AuditAnalyzer` plugin type and the surrounding machinery (report controller, settings form, runner, State-API score storage, render/component builder, DruScan client, cron scheduler with two queue workers). Each check lives in a submodule that registers one analyzer plugin, and `audit_all` enables every production-ready analyzer at once. Analyzers execute live on each detail-page view or `Run all audits` click (results are never cached — only numeric scores and issue counts are persisted in State). The report renders Lighthouse-style score circles, collapsible issue sections with severity badges, and client-side faceted filtering. Drush commands emit AI-optimized JSON with `--filter` and a `--fail-on` severity gate, so the framework doubles as a CI quality gate. The whole UI is gated behind the `view audit results` permission (settings behind `administer audit configuration`).

---

- Take over an inherited site: enable `audit audit_all` and run one full audit for a scored inventory of modules, updates, cache config, unused fields, and performance issues.
- Add a report to Reports > Audit that lists every analyzer with its score, status, summary counts, and last-run time.
- Run all audits at once with a batch job (`/admin/reports/audit/run-all`) that recalculates the weighted Project Score afterward.
- Open a per-analyzer detail page to re-run that check live and see grouped issue sections with error/warning/notice counters.
- Gate CI on code health: `drush audit:run phpstan --fail-on=error` exits non-zero when the PHPStan analyzer finds an error.
- Get machine-readable output for an AI agent: `drush audit:run all --format=json` returns combined findings, totals, and per-analyzer scores.
- List every available analyzer with score and last-run: `drush audit` (alias of `audit:list`), or `drush audit --format=json`.
- Filter findings to a module: `drush audit:run phpstan --filter="module:audit"`.
- Filter by severity and category together: `drush audit:run security --filter="severity:error,category:security"`.
- Discover the filter values an analyzer produced: `drush audit:filters security`.
- Use it as a quality gate for AI-generated code: run `audit_phpcs`, `audit_phpstan`, and `audit_cache` in staging before every deploy.
- Enable only the analyzers you need (each submodule is independent) — e.g. just `audit_updates` + `audit_security` for a maintenance dashboard.
- Track pending updates and flagged security releases across a portfolio by enabling DruScan sync and viewing all sites in one dashboard.
- Weight the Project Score per analyzer via the `multipliers` config (set an analyzer's multiplier to 0 to exclude it).
- Configure global code-scan scope once (`scan_directories`, `exclude_patterns`, `execution_timeout`) for all file-based analyzers.
- Identify maintenance risk with `audit_complexity` (cyclomatic complexity, maintainability index, Drupal anti-patterns) on custom code.
- Detect copy-paste with `audit_duplication` (jscpd) across PHP/Twig/JS/CSS in custom modules and themes.
- Audit content structure: `audit_entity` reports content volume, revision bloat, and translation gaps by bundle.
- Audit display configuration: `audit_fields` flags unused fields, orphaned storage, and excess view/form modes.
- Review caching correctness: `audit_cache` inspects bins, backends, cache tags, and invalidation patterns.
- Run a single custom analyzer plugin from your own submodule by extending `AuditAnalyzerBase` and adding a `#[AuditAnalyzer]` attribute.
- Schedule background recalculation and DruScan sync from cron (throttled to once per 24h each, one pending queue item at a time).
- Provide per-site status telemetry (Drupal/PHP/DB/webserver versions) to DruScan alongside the scores.
