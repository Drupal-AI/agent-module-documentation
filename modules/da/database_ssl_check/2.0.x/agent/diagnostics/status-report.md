<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Status Report diagnostics

The entire module is one function in `database_ssl_check.install`:
`database_ssl_check_requirements($phase)` (implements `hook_requirements()`).

## When it runs
Only at the `runtime` phase — i.e. when Drupal renders the Status Report at `/admin/reports/status`
(and via `drush core:requirements`). It returns `[]` for install/update phases, so it never blocks
installation or updates.

## What it does, step by step
1. `$db = Database::getConnection();` — the active default connection.
2. `$opts = $db->getConnectionOptions();` then `$conn = $db->open($opts);` — opens a **new** PDO
   connection with identical options, so it can read PDO attributes directly.
3. Client version row (`database_ssl_check_client_version`):
   - Value = `$conn->getAttribute(PDO::ATTR_CLIENT_VERSION)`, or `(Unknown)` if empty.
   - Severity `REQUIREMENT_OK` when known, else `REQUIREMENT_WARNING`.
4. Connection status row (`database_ssl_check_connection_status`):
   - Base value = `$conn->getAttribute(PDO::ATTR_CONNECTION_STATUS)`.
   - If the status does **not** contain `via UNIX socket` (i.e. a TCP/IP link), it runs:
     `SHOW STATUS WHERE Variable_name LIKE ('Ssl%')`, fetched with
     `fetchAllAssoc('Variable_name', PDO::FETCH_ASSOC)`.
     - If `Ssl_version` or `Ssl_cipher` is empty → append `", unencrypted"`, severity
       `REQUIREMENT_WARNING`.
     - Otherwise → append `", <Ssl_version> (<Ssl_cipher>)"`, severity `REQUIREMENT_OK`.
   - UNIX-socket connections skip the SSL probe (local, not over the network) and report the raw
     status at `REQUIREMENT_OK`.

## Notes / caveats
- The `SHOW STATUS ... LIKE ('Ssl%')` syntax is MySQL/MariaDB-specific; the module targets those
  drivers. On other drivers the status query would not apply.
- The `SHOW STATUS` query is a fixed string literal with no user/request input.
- The socket test uses `strpos(...)` truthily (`!strpos(...)`), so it treats a match at offset 0 the
  same as no match — a minor edge case, not a behavior you configure.
- Nothing is written or cached; the check re-runs each time the Status Report is built.

## Operating
- Enable: `drush en database_ssl_check` (no config, no permissions of its own).
- View: `/admin/reports/status` — the two rows appear under the standard requirements list.
- Interpretation: a "..., unencrypted" value at warning severity on a TCP connection means the DB
  session negotiated no SSL/TLS; configure your driver's SSL options in `settings.php` and reload.
