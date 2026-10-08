<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Security — the `security` analyzer

`SecurityAnalyzer` (`src/Plugin/AuditAnalyzer/SecurityAnalyzer.php`), a `Drupal\audit\AuditAnalyzerBase` subclass declared with
`#[AuditAnalyzer(id: 'security', output_directory: 'security', weight: 1)]`.

## Install / enable

- Enable: `drush en audit_security` (pulls in audit).
- Requirements (`checkRequirements()`): None — pure Drupal/config inspection.
- Appears as a secondary tab and detail page under **Reports → Audit** once the parent `audit` module is enabled.

## What it analyzes

audit_security registers the `security` AuditAnalyzer plugin (SecurityAnalyzer, weight 1 — highest priority). It runs eleven scored checks: a static code-security scan (regex rules in `rules/static_security_rules.yml` applied to PHP/YAML in the scan directories), risky administrative permissions granted to untrusted roles (an admin can whitelist roles via the `trusted_roles` setting), production error-reporting level, dangerous text-format/filter configuration, file-system permissions and the SA-2006-006 `.htaccess`, `trusted_host_patterns`, admin (uid 1) account exposure, Views access control, allowed upload extensions, open account creation, and a lightweight self-request that inspects the returned HTTP security headers. Findings render as scored, faceted issue lists on the Security detail page.

### Scored checks (contribute to the score)
- `code_security` — Static Code Security
- `permissions` — Administrative Permissions
- `error_reporting` — Error Reporting
- `input_formats` — Text Formats
- `file_system` — File System Security
- `trusted_hosts` — Trusted Hosts
- `admin_user` — Admin Account
- `views_access` — Views Access Control
- `upload_extensions` — Upload Security
- `account_creation` — Account Creation
- `security_headers` — Security Headers

### Informational checks (no score)
- (none)

## Configuration

Config object **`audit_security.settings`** (defaults in `config/install/audit_security.settings.yml`, schema in `config/schema/audit_security.schema.yml`). Values are edited on the parent **`audit.settings`** form (the base module auto-collects `buildConfigurationForm()` output and saves via `processConfigurationValue()`).

| Key | Default |
|---|---|
| `trusted_roles` | `[]` |


## Operating it

- **UI**: `/admin/reports/audit/security` (permission `view audit results`); settings under
  `/admin/reports/audit/settings` (permission `administer audit configuration`).
- **Cron**: queued into `audit_processor` by the parent `hook_cron()`; the score is recalculated into the Project Score.
- **Drush**: `drush audit:run security --format=json`; filter with `--filter="severity:error"` /
  `--filter="module:<name>"`; discover filter values with `drush audit:filters security`.
- **Output contract**: `analyze()` returns `['_files' => [...], 'score' => ['factors' => [...]]]`. Sections map to
  checks via `getAuditChecks()`; the base class renders scored sections as faceted issue lists and informational
  sections as tables. Only the score is persisted (State API via `audit.score_storage`); result rows are regenerated
  on each view.
