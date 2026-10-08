<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — audit.settings

Single config object `audit.settings` (schema `config/schema/audit.schema.yml`, defaults
`config/install/audit.settings.yml`). Edited at `/admin/reports/audit/settings`
(`Form\AuditSettingsForm`, route `audit.settings`, permission `administer audit configuration`).
Per-analyzer settings live in each submodule's own `<module>.settings` object.

## Keys

- `druscan.enabled` (bool, default false) — turn on portal sync.
- `druscan.project_api_key` / `druscan.environment_api_key` (string) — DruScan credentials.
- `druscan.api_url` (string, schema-only) — base-URL override; **not** in the install defaults and
  removed from stored config by `audit_update_10004`. Now defaults to `https://app.druscan.com/api/v1`
  in `DruscanClient::DEFAULT_API_URL`; override only via `settings.php`.
- `user_type` (string, default `mixed`) — primary site profile (used by some analyzers'
  recommendations).
- `scan_directories` (multiline string, default `web/modules/custom` + `web/themes/custom`) — roots
  the file-based analyzers scan.
- `exclude_patterns` (multiline string) — glob patterns skipped by code scans (defaults exclude
  `*Test.php`, `tests/`, `node_modules/`, `*.js`, `*.css`, …).
- `execution_timeout` (int, default 60) — seconds budget for external tool processes.
- `multipliers` (sequence of int, keyed by analyzer id) — Project-Score weight per analyzer; 0
  excludes it. Falls back to the plugin's attribute `weight` (default 3) when unset.

## Settings form sections

`AuditSettingsForm` builds three groups:
1. **DruScan** — enable checkbox, the two API-key textfields (with an AJAX **Test connection** button
   calling `DruscanClientInterface::testConnection()`), and rate-limit info. When a key or the
   enabled flag is set in `settings.php`, `hasOverrides()` disables/hides that field and shows the
   value as read-only — the form recommends storing keys in `settings.php`/`settings.local.php`, not
   exported config.
2. **General** — `user_type`, `scan_directories`, `exclude_patterns`, `execution_timeout`, plus a
   **Score multipliers** sub-section rendering a Critical…Off select per discovered analyzer (writes
   `multipliers.<id>`).
3. **Submodules** — one collapsible group per analyzer that returns fields from its
   `buildConfigurationForm()`, and surfaces any `checkRequirements()` warnings (e.g. missing phploc /
   jscpd). Values are passed through each analyzer's `processConfigurationValue()` before saving.

## settings.php overrides (recommended for credentials)

```php
$config['audit.settings']['druscan']['enabled'] = TRUE;
$config['audit.settings']['druscan']['project_api_key'] = 'druscan_proj_…';
$config['audit.settings']['druscan']['environment_api_key'] = 'druscan_env_…';
// Optional endpoint override:
$config['audit.settings']['druscan']['api_url'] = 'https://app.druscan.com/api/v1';
```

## Install / uninstall

- `audit.install` update hooks migrate legacy state: `_10004` drops `druscan.api_url` from config;
  `_10005` deletes the legacy `audit_processor` queue and seeds `audit.last_calculated_at`.
- `hook_uninstall` deletes all `audit.score.*`, the scores index, project score, DruScan/scheduler
  timestamps, pending queues, and any legacy `private://audit` directory.
