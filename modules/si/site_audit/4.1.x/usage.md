Site Audit is a static site-analysis platform that runs a suite of best-practice checks against a Drupal site and produces reports (text, HTML, JSON, or Markdown) with actionable recommendations, via Drush or an admin page.

---

The module organises analysis into two plugin types: **checklists** (a "report", plugin type `site_audit_checklist`, in `src/Plugin/SiteAuditChecklist/`) and **checks** (individual tests, plugin type `site_audit_check`, in `src/Plugin/SiteAuditCheck/`). A check declares which checklist it belongs to via its annotation's `checklist` property; a checklist runs all its checks in weight order, scoring each PASS/WARN/FAIL/INFO and rolling them up into a percentage. Ships 13 reports — `best_practices`, `block`, `cache`, `codebase`, `content`, `cron`, `database`, `extensions`, `security`, `status`, `users`, `views`, `watchdog` — with ~60 checks. You run it with Drush (`drush site_audit:audit` / alias `audit`, `drush audit-all`, `drush audit-list`) choosing `--format=text|html|json|markdown`, `--detail`, `--bootstrap`, and `--skip=...`; or from the admin page at `/admin/reports/site-audit`, whose *Settings* form (`site_audit.settings` → `reports`) limits which reports the page runs. Analysis is static (no requests to the running site) and non-intrusive. It is extensible: other modules add reports/checks by extending `SiteAuditChecklistBase` / `SiteAuditCheckBase` with the `@SiteAuditChecklist` / `@SiteAuditCheck` annotations. Two optional submodules add a saved-report content entity (`site_audit_report_entity`) and remote/cron report sending (`site_audit_send`).

---

- Run a full best-practice audit of a Drupal site from the command line (`drush audit`).
- Generate an HTML audit report to share with a client or team.
- Produce a JSON report to feed audit results into CI or a dashboard.
- Produce a Markdown report to paste into a ticket or wiki.
- Check that Drupal page caching and CSS/JS aggregation are configured optimally (cache report).
- Audit security-relevant settings (security report).
- Review cron configuration and last-run status (cron report).
- Inspect database size, engine, collation, and row counts (database report).
- Flag development/unrecommended modules left enabled in production (extensions report).
- Review Views caching and count (views report).
- Summarise watchdog/dblog volume, age, PHP errors, and 404s (watchdog report).
- Audit users, roles, blocked accounts, and the uid-1 account (users report).
- Check best-practice folder structure, settings.php, services.yml, fast-404 (best_practices report).
- View the audit as an admin page at /admin/reports/site-audit.
- Limit the admin audit page to a chosen subset of reports via the Settings form.
- Skip specific reports or checks in a run (`--skip=block,status` or `--skip=StatusSystem`).
- Run a single report only (`drush audit cache`).
- Show extra detail even for passing checks (`--detail`).
- Wrap HTML output with Bootstrap styling (`--bootstrap`).
- List every available report and check (`drush audit-list`).
- Permanently opt out of a check via settings.php config override.
- Add a custom report by extending SiteAuditChecklistBase with a `@SiteAuditChecklist` annotation.
- Add a custom check to an existing (or new) report by extending SiteAuditCheckBase.
- Feed data between checks in a report using the shared registry.
- Save audit reports as entities over time (site_audit_report_entity submodule).
- Send audit reports to a remote Site Audit server or on a cron schedule (site_audit_send submodule).
- Integrate audit pass/fail into the core Site module's "site state" factors.
