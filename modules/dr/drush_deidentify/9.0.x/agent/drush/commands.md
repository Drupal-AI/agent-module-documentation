<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

## `drush_deidentify:db-export` (alias `ice-export`)
Options:
- `--result-file=<path>` — output file, relative to Drupal root (required for a saved dump).
- `--gzip` — compress via gzip (must be in `$PATH`).
- `--omit_tables=<t1,t2>` — extra tables exported as structure only.

Always structure-only: the core cache/cachetags tables. Other modules can append to the structure-only list by implementing `hook_drush_deidentify_export(array &$default_tables)`. Internally builds Drush SQL options and calls `SqlBase::create($options)->dump()`.

## `drush_deidentify:db-clean` (alias `ice-clean`)
- Argument: comma-separated `table~column` pairs, e.g. `watchdog~message,watchdog~location`.
- Overwrites the named columns with `fakerphp/faker`-generated values in place.

## Typical flow
1. Sync/import a production DB into a scratch environment.
2. `drush ice-clean users_field_data~mail,users_field_data~name` (adjust to your schema).
3. `drush ice-export --result-file=deid.sql --gzip` to hand off a sanitized dump.
