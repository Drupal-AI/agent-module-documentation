<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Database SSL Check (database_ssl_check) — agent index

Read-only diagnostic module: reports whether Drupal's database connection is encrypted (SSL/TLS),
plus the negotiated cipher/version and the PDO client-library version, on the core Status Report page.
Version `2.0.1`. Core `^9 || ^10 || ^11`. Package: Administration. License GPL-2.0-or-later.

## What it provides
- One implementation: `database_ssl_check_requirements($phase)` in `database_ssl_check.install`
  (runs at the `runtime` phase, i.e. on `/admin/reports/status`).
- Two Status Report rows: `database_ssl_check_client_version` ("Database client version") and
  `database_ssl_check_connection_status` ("Database connection status").
- No routes, no permissions, no services, no config, no entities/plugins, no Drush commands,
  no submodules, no dependencies beyond Drupal core.

## How it works (mechanism)
- Opens a fresh PDO connection from the active connection's options (`Database::getConnection()`,
  `getConnectionOptions()`, `$db->open($opts)`).
- Reads `PDO::ATTR_CLIENT_VERSION` and `PDO::ATTR_CONNECTION_STATUS`.
- For non-UNIX-socket connections, runs the static query `SHOW STATUS WHERE Variable_name LIKE ('Ssl%')`
  and reports `Ssl_version` / `Ssl_cipher`; missing values → status flagged "unencrypted"
  (`REQUIREMENT_WARNING`). MySQL/MariaDB oriented.

## Operate it
- Install: `drush en database_ssl_check`. No configuration. View results at `/admin/reports/status`.

## Solution docs
- [Status Report diagnostics](diagnostics/status-report.md) — the requirements hook, the two rows,
  severities, and the UNIX-socket vs TCP behavior.
