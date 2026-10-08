<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Drush/Commands/IpAnonCommands.php` (autowired). Two commands, no aliases.

## `ip_anon:scrub`

Scrubs IP addresses from the database according to the configured retention period for each
table — the same work `hook_cron()` does.

```bash
drush ip_anon:scrub
```

- If `ip_anon.settings.policy` is **truthy**, it calls `IpAnonymize::scrub()` and logs
  *"IP addresses scrubbed."*
- If `policy` is falsy, it does **not** scrub and warns
  *"Retention policy is configured to preserve IP addresses."*

## `ip_anon:policy`

Displays the current retention policy as a table (one row per known table).

```bash
drush ip_anon:policy
drush ip_anon:policy --format=json     # options: ['format' => 'table'] by default
```

- For each table from `IpAnonymize::getTables()` it prints the retention period, formatted via
  `DateFormatter::formatInterval()`, or **"Forever"** when the period is negative/non-numeric.
- If `policy` is falsy it also warns that IPs are being preserved (but still prints the table).

Returns a `RowsOfFields` (`table`, `retention period`), so it honours Drush `--format`.
