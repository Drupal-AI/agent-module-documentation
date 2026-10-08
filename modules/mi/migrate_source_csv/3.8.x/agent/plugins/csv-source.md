# The `csv` migrate source plugin

Reference it in a migration's `source:` section. Plugin id `csv`, class
`Drupal\migrate_source_csv\Plugin\migrate\source\CSV` (extends `SourcePluginBase`,
is `ConfigurableInterface`). This is a *source* plugin — the module does not define a new
plugin *type*.

## Configuration keys
- **`path`** (required) — path to the CSV. Stream wrappers (`public://`, `s3://`) work.
  `/dev/null` yields an empty source (useful for `migration_lookup` stubs).
- **`ids`** (required) — flat array of unique string column names forming the record key.
- **`header_offset`** (optional) — zero-based index of the header record. Defaults to `0`.
  Set to `null` for a file with no header row (then supply `fields`).
- **`fields`** (optional) — nested list of `{ name, label }` used instead of / overriding the
  header row. `name` is required per entry.
- **`delimiter`** (optional, 1 char) — field delimiter, default `,`.
- **`enclosure`** (optional, 1 char) — quote character, default `"`.
- **`escape`** (optional, 1 char) — escape character, default `\`.
- **`create_record_number`** (optional bool) — add an incrementing per-row value.
- **`record_number_field`** (optional) — field name for that value, default `record_number`.

Validation throws `InvalidArgumentException` if `path` or `ids` are missing, `ids` is not a
flat unique array of strings, a control character isn't exactly one char, or `header_offset`
is negative/non-integer.

## Example (minimal)
```yaml
source:
  plugin: csv
  path: /tmp/countries.csv
  ids: [id]
```

## Example (most options)
```yaml
source:
  plugin: csv
  path: public://import/countries.csv
  ids: [id]
  delimiter: '|'
  enclosure: "'"
  escape: '`'
  header_offset: null      # no header row
  fields:
    - { name: id, label: ID }
    - { name: country, label: Country }
```

Then map columns under `process:` and pick a `destination:` as with any migration. Run with
Migrate Tools (`drush migrate:import <id>`).

> Note: `config/schema/migrate_source_csv.source.schema.yml` still lists older keys
> (`keys`, `header_row_count`, `column_names`); the runtime plugin uses the keys above.
