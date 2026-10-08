<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DrupalFit runs a scored, pluggable site "fitness" audit (security, performance, best-practice, content/config) and saves each run as a reviewable report.

---

DrupalFit generates a comprehensive site health/status report from a single admin page at `/admin/reports/drupalfit-report`. It discovers `fit_check` plugins (about 58 ship with 1.1.3 — HTTPS enforcement, dangerous permissions, outdated core/contrib, cron/queue health, aggregation, caching, file permissions, unused config, and more), runs them as a batch, sorts them into `fit_check_group` categories (Security, Performance, Best Practices, Content & Config, plus externally-provided SEO and Accessibility), and computes a 0–100 score per group and overall using a severity-weighted model. Each run is persisted as a `fit_report_history` content entity, so history is browsable and re-viewable; the latest results are also served as JSON at `/api/v1/drupalfit-report`. Custom checks and groups are added by writing attribute-annotated plugin classes in any module. An optional cloud connection (API key set on the Settings tab) fetches SEO/accessibility scores from the external DrupalFit platform and embeds its dashboard in an iframe. The optional `drupalfit_report_export` submodule adds CSV, JSON, and printable-HTML export of a stored report.

---

- Run an on-site security and health audit of a Drupal site without leaving the admin UI.
- Get an overall 0–100 "fitness" score plus per-category scores (Security, Performance, Best Practices, Content & Config, SEO, Accessibility).
- Review findings grouped by severity (Critical / High / Medium / Low / Ok / Info) with remediation guidance.
- Detect outdated Drupal core and contrib modules (via the core Update module data).
- Check HTTPS enforcement, HSTS headers, SameSite cookies, referrer-policy, trusted-host patterns, and reverse-proxy safety.
- Flag dangerous permissions granted to anonymous/authenticated roles and exposed database credentials.
- Audit performance settings: CSS/JS aggregation, page cache kill switch, Views caching, image toolkit, PHP OPcache, queue backlog, last cron run.
- Surface content/config hygiene problems: unused fields, image styles, menus, vocabularies, orphaned media, duplicate titles, revision bloat, mismatched entity definitions, pending DB updates.
- Keep a history of past audits as `fit_report_history` entities and compare runs over time.
- Consume audit results programmatically as JSON from `/api/v1/drupalfit-report` (CSRF-token-protected, permission-gated).
- Write custom `fit_check` plugins to enforce project-specific policies, using the `FitWeight` severity enum for scoring impact.
- Group custom checks under a new `fit_check_group` plugin with its own display weight and score weight.
- Export a stored report to CSV for spreadsheets or ticketing (with the export submodule).
- Export a stored report to JSON for pipelines or archival (with the export submodule).
- Produce a printable HTML/PDF-style report to hand to stakeholders (with the export submodule).
- Gate report access with the dedicated "View DrupalFit reports" permission, and settings/history with "Administer DrupalFit" / "Administer fit report history".
- Connect to the DrupalFit cloud platform for enhanced SEO and accessibility scoring, shown alongside on-site results.
- Embed the DrupalFit platform dashboard in an in-admin iframe tab once an API key is configured.
- Run scheduled/periodic health checks by triggering a fresh report and archiving the resulting history entity.
- Feed the JSON API or exported files into CI to fail a build when the site score drops below a threshold.
- Provide auditors or clients a shareable, scored snapshot of a site's security and maintenance posture.
