<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config object `dbxschema.settings`

Source: `config/install/dbxschema.settings.yml`, `config/schema/dbxschema.schema.yml`. There is **no
settings form and no configure route** — the module has no admin UI. Edit via config sync,
`\Drupal::configFactory()->getEditable('dbxschema.settings')`, or Drush `config:set`.

## Keys

- **`reserved_schema_patterns`** (`sequence` of strings; used as an associative array
  `pattern => description`) — schema-name patterns that tooling must not create/overwrite.
  `isSchemaReserved()` / `isInvalidSchemaName()` consult it.
  - Wildcards: a `*` **not** preceded by `.` is rewritten to `.*` (so both simple `*` globs and bare
    regex — no `/` delimiters — work).
  - Default install value reserves `'_test*' => 'testing purposes'`.
  - Each driver submodule adds the **Drupal install's own schema name** at install time
    (`dbxschema_{pgsql,mysql}_install()` → `getDrupalSchemaName()`, description `'Drupal installation'`)
    so cross-schema tooling can't clobber the live site.
- **`test_schema_base_names`** (`sequence` of strings; associative `module_machine_name => prefix`) —
  base name prefixes used to generate test schemas. Default: `default: _test`. These prefixes should be
  matched by a `reserved_schema_patterns` entry so generated test schemas don't collide with real ones.

## Example

```yaml
# dbxschema.settings.yml
reserved_schema_patterns:
  '_test*': 'testing purposes'
  'public': 'Drupal installation'
  'pg_*': 'PostgreSQL system schemas'
test_schema_base_names:
  default: '_test'
```

## Runtime API

Patterns can also be added/removed at runtime through `DatabaseTool`
(`reserveSchemaPattern()`, `freeSchemaPattern()`, `getReservedSchemaPattern()`) — those operate on a
static in-memory copy seeded from this config (`initSchemaReservation()`), not on the stored config.
See [../api/database-tool.md](../api/database-tool.md).
