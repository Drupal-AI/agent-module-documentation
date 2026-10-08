<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# abusive traffic (abusive_traffic) — agent index

Acquia-Cloud-specific tool that **parses hourly Apache access logs to find IPs hammering your site
and emails you to ban them**. Package `Other`. Core `^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.2. No module dependencies; **requires Acquia Cloud Next hosting** and the **phpseclib**
library (`phpseclib/phpseclib:~3.0`) for optional SFTP forwarding.

## What it actually is

- No entities, no plugins, no permissions of its own, no services, no config schema, no
  `config/install`, no `.install`. Just: one settings form, one config object, three Drush
  commands, and a `hook_mail()`.
- Workflow: two Drush commands run as hourly cron jobs. `generate-log` asks the Acquia Cloud API
  (v2) to build an Apache access log for the last hour; ~5 min later `get-log` downloads it, counts
  hits per client IP, and emails a recipient list any IP at/over a threshold.

## Provides

- **Config form / route** `abusive_traffic.settings` → `/admin/config/system/abusive-traffic`,
  permission **`administer site configuration`** (`AbusiveTrafficSettingsForm`, config object
  `abusive_traffic.settings`). Menu link under *Configuration → System*.
- **Drush commands** (`src/Drush/Commands/AbusiveTrafficCommands.php`):
  `abusive_traffic:generate-log` (alias `atgen`), `abusive_traffic:get-log` (alias `atget`),
  `abusive_traffic:list-applications` (alias `atlist`).
- **`hook_mail()`** (`abusive_traffic.module`, key `threshold_exceeded`) — HTML alert listing each
  flagged IP with abuseipdb.com and Ban-page links.

## Configuration & secrets

- Config keys: `threshold` (int, default 100), `ignorelist` (textarea, wildcard `*`),
  `emaillist` (comma-separated), `forward_log_files` (bool).
- Credentials come from **Acquia secrets** config objects, not module config:
  `abusive_traffic_acquia_client_id`, `abusive_traffic_acquia_client_secret`,
  `abusive_traffic_acquia_application_uuid`, and (if SFTP forwarding on)
  `abusive_traffic_sftp_username` / `_password` / `_server` / `_path` — each read as `->get('key')`.

## Solution docs

- **Settings form, config object, secrets** → [config/settings.md](config/settings.md)
- **The three Drush commands, the Acquia API flow, log parsing & alert email** →
  [api/drush-commands.md](api/drush-commands.md)
