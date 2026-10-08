<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internals: table names, indexes, rollback fix

All logic is in `SmartSql` (extends core `Sql`). It overrides three things.

## 1. Map / message table names (the [#2845340] fix)

In the constructor, after `parent::__construct()`, it recomputes `$this->mapTableName` and
`$this->messageTableName` from the migration id:

- `$machine_name = str_replace(PluginBase::DERIVATIVE_SEPARATOR, '__', $migration->id())`
  — the derivative separator (`:`) becomes `__`.
- Base names are `m_map_<machine_name>` and `m_message_<machine_name>` (lower-cased). Note
  the short `m_map_` / `m_message_` prefixes vs core's longer `migrate_map_` /
  `migrate_message_`.
- The DB prefix length is subtracted from the 63-char budget (`getPrefix()` on core ≥ 10.1,
  else `tablePrefix()`).
- **If the full name fits in `63 - prefix_length` chars**, it is used verbatim.
- **Otherwise** the name is truncated to `45 - prefix_length` chars and suffixed with
  `_` + the first 17 chars of `md5($machine_name)`, giving a deterministic, unique short
  name.

This is why two long-id migrations no longer collide on one table.

## 2. Extra indexes on the map table

`ensureTables()` calls `parent::ensureTables()` then adds two indexes if missing:

- **`row_status`** — index on `source_row_status` (`ensureStatusIndex()`).
- **`destination`** — index across the destination id columns (`ensureDestinationIndex()`),
  built from `$migration->getDestinationPlugin()->getIds()` as `destid1`, `destid2`, ….
  To stay under MySQL's **3072-byte** max key length it starts with all destination columns
  in one group and, on a `1071` "key too long" error, drops the created indexes and retries
  with a smaller chunk size (splitting into `destination`, `destination1`, …) until it
  succeeds or there are no columns left. Non-1071 database errors are re-thrown.

## 3. `getRowByDestination()` (the [#3227549] / [#3227660] fixes)

Overridden so it:

- returns `NULL`/`[]` (never `FALSE`) when destination keys are missing, and
- on core ≥ 9.3 returns `$result ?? []` (an empty array for a missing row) instead of
  `FALSE`; on older core returns `['rollback_action' => 99999]` as a rollback-safe default.

This keeps `MigrateExecutable::rollback()` working for migrations with composite
destination ids.

`getCoreMajorMinor()` is a small helper returning e.g. `"11.4"` from `\Drupal::VERSION`,
used for the version-conditional behavior above.

[#2845340]: https://drupal.org/i/2845340
[#3227549]: https://drupal.org/i/3227549
[#3227660]: https://drupal.org/i/3227660
