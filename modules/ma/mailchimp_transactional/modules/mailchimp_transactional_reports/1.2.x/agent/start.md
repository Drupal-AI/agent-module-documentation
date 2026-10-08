# Mailchimp Transactional Reports — agent index

Submodule of **mailchimp_transactional**. Adds two admin **report pages** (dashboard + account
summary) sourced from the Mailchimp Transactional API. No config entities or settings of its own;
its only local surface is one permission and two routes.

- **Routes, the permission (and its routing typo), and the reporting service** →
  [configure/dashboard.md](configure/dashboard.md)

Key facts:
- Routes: `mailchimp_transactional_reports.dashboard` (`admin/reports/mailchimp_transactional`),
  `mailchimp_transactional_reports.summary` (`admin/reports/mailchimp_transactional/summary`),
  controller `Controller\ReportsController` (`dashboard()` / `summary()`).
- Permission **defined**: `view mailchimp transactional reports` (restricted). ⚠️ The route
  `_permission` requirement is written `view mailchimp_transactional reports` (underscore) — a
  mismatch, so only user 1 reaches the pages until reconciled.
- Service `mailchimp_transactional_reports.service` (`ReportsService`) wraps the base API client
  (`mailchimp_transactional`) and caches via `cache.mailchimp_transactional`; data from
  `getTagsAllTimeSeries()` (volume) and `getUser()` (summary).
- Libraries `reports-stats` (JS) + `google-jsapi`. No config schema, no Drush, no plugin type.
