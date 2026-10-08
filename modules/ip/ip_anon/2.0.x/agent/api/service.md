<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `IpAnonymize` service

Service class `Drupal\ip_anon\IpAnonymize` (interface
`Drupal\ip_anon\IpAnonymizeInterface`). Autowired; inject the interface or fetch
`\Drupal::service(IpAnonymizeInterface::class)`.

## Interface methods

- `scrub(): void` — anonymize IPs past their retention period across all known tables.
- `getDefaultColumns(): array` — `['hostname' => 'hostname', 'timestamp' => 'timestamp']`.
- `getTables(): array` — the tables to scrub, keyed by table name, each an array of
  `['hostname' => <col>, 'timestamp' => <col>, 'callback'? => callable]`. Always includes
  `sessions` (if that table exists) and whatever `hook_ip_anon_alter()` adds.
- `getTableDescription(string $table): string` — human description (from schema/DB comment).

## What `scrub()` does

For each `table => columns` from `getTables()`:

```php
$period = $config->get("period_$table");
if (!is_numeric($period) || $period < 0) { continue; }   // never scrub
$rows = $connection->update($table)
  ->fields([$columns['hostname'] => '0'])                  // overwrite hostname with '0'
  ->condition($columns['timestamp'], requestTime - $period, '<=')
  ->condition($columns['hostname'], '0', '<>')            // skip already-scrubbed rows
  ->execute();
if (!empty($columns['callback']) && $rows) { $columns['callback'](); }  // e.g. cache reset
```

So anonymization is a **destructive in-place UPDATE** that replaces the client IP/hostname
with the string `'0'`; original IPs are not recoverable afterwards.

## Invocation points

- `Drupal\ip_anon\Hook\Cron` (`#[Hook('cron')]`) calls `scrub()` when `policy` is truthy.
- The `ip_anon:scrub` Drush command (see [../drush/commands.md](../drush/commands.md)).

Note: `scrub()` itself does **not** check `policy` — the cron hook and the Drush command do.
If you call the service directly it will scrub regardless of the `policy` flag (respecting only
the per-table periods).
