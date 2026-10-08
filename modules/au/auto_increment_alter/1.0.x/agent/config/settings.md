<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk configuration via settings.php

The module has **no Drupal config objects and no config schema**. The two bulk operations
(`alterTables()` / `alterContentEntities()`, the `:tables` / `:content-entities` Drush commands,
and the two confirm forms) read their input directly from `$settings` in `settings.php`, via the
injected `@settings` service (`Drupal\Core\Site\Settings`). A copy of the examples ships as
`example.settings.auto_increment_alter.php`.

## `auto_increment_alter_tables` — raw table names → integer value

```php
$settings['auto_increment_alter_tables'] = [
  'node' => 500,
  'node_revision' => 1000,
  'users' => 100,
  'taxonomy_term_data' => 200,
  'taxonomy_term_revision' => 200,
  'file_managed' => 300,
  'media' => 700,
  'media_revision' => 700,
];
```

- Keys are **raw database table names**; values are the new AUTO_INCREMENT integers.
- `AutoIncrementAlter::alterTables()` logs an error and returns if the setting is missing/not an
  array or empty, otherwise loops and calls `alterTableAutoIncrement()` per entry (each verifies
  `tableExists()` and rejects negatives).

## `auto_increment_alter_content_entities` — entity machine name → value(s)

```php
$settings['auto_increment_alter_content_entities'] = [
  'node' => [500, 1000],  // [base, revision]
  'user' => [100],        // one value → used for base and revision
  'taxonomy_term' => [200],
  'file' => 300,          // scalar → used for base and revision
  'media' => 700,
];
```

- Keys are **content-entity machine names** (not table names). The base and revision tables are
  resolved with `entity_type.manager` (`getBaseTable()` / `getRevisionTable()`).
- Value forms accepted (see `alterContentEntities()`): a two-element array `[base, revision]`; a
  one-element array (used for both); or a bare integer (used for both). Entities not present in the
  install are filtered out with a warning. Entities without a revision table ignore the revision
  value.

## Applying it

```bash
drush auto-increment-alter:tables            # applies auto_increment_alter_tables
drush auto-increment-alter:content-entities  # applies auto_increment_alter_content_entities
```

Or use the confirm forms at `/admin/config/development/auto-increment-alter/tables` and
`.../content-entities`, which preview the settings-driven plan and disable the submit button when
the relevant `$settings` array is empty or not an array.

Because these arrays live in `settings.php` (deploy-managed PHP, not exportable Drupal config),
changing them requires editing the file and does not participate in config import/export.
