<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Audit: Security (audit_security) — agent index

Submodule of the **Audit** framework. Ships one `audit_analyzer` plugin and no routes, services, permissions or Drush commands of its own — it plugs into the parent `audit` module's runner, settings form and report UI.

- **The analyzer, its checks, config and how it runs** → [plugins/security-analyzer.md](plugins/security-analyzer.md)

## What it actually is

- One plugin: **`SecurityAnalyzer`** (id **`security`**, output dir `security`, default weight `1`), in
  `src/Plugin/AuditAnalyzer/SecurityAnalyzer.php`, extending `Drupal\audit\AuditAnalyzerBase` and declared with the
  `#[AuditAnalyzer(...)]` attribute. Label *"Security"*.
- **Depends on**: `audit`. External tooling: none.
- No `configure` route of its own.
- **Config** (`audit_security.settings`, schema yes): `trusted_roles`.

## Checks (`getAuditChecks()`)

  - `code_security` — Static Code Security (scored)
  - `permissions` — Administrative Permissions (scored)
  - `error_reporting` — Error Reporting (scored)
  - `input_formats` — Text Formats (scored)
  - `file_system` — File System Security (scored)
  - `trusted_hosts` — Trusted Hosts (scored)
  - `admin_user` — Admin Account (scored)
  - `views_access` — Views Access Control (scored)
  - `upload_extensions` — Upload Security (scored)
  - `account_creation` — Account Creation (scored)
  - `security_headers` — Security Headers (scored)

## How it runs

- Executed by the parent `audit.runner` service when an admin opens `/admin/reports/audit/security`
  (permission **`view audit results`**), on cron via the `audit_processor` queue, or headless via
  `drush audit:run security`. `analyze()` returns a `_files` + `score` structure; only the score is
  persisted (State API). Results render through the parent's escaped `audit_*` theme components.
- See [plugins/security-analyzer.md](plugins/security-analyzer.md) for the full check list, config keys and operation notes.
