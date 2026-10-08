# Migrate plugins added by Migration Tools

All are standard Migrate/Migrate Plus plugins you reference by `plugin:` / `source: plugin:` /
`data_parser_plugin:` in a `migrate_plus.migration.*` config. Migration Tools defines **no plugin
manager of its own** — these extend core Migrate types.

## Process plugins (`process:` pipeline)

### `convert_boolean`
Maps string/boolean source values to Drupal boolean. Built-in TRUE set: `true/TRUE/1`; FALSE set:
`false/FALSE/null/NULL/0`. Extend with `map_true:` / `map_false:` arrays.
```yaml
field_bool:
  plugin: convert_boolean
  source: flag
  map_true: [yes, Yes, si]
  map_false: [no, No, nada]
```

### `skip_on_substr`
Skip the `row` or `process` when a substring is (or, with `not_equals: true`, is not) found in the
source. Keys: `value` (string or list), `case_sensitive` (bool), `not_equals` (bool), `method`
(`row`|`process`).

### `skip_on_not_empty`
Skip `row` or `process` when the input value is not empty (empty string, NULL, FALSE, 0, '0', []).
Keys: `method` (`row`|`process`), `message` (logged to the migrate message table, `row` method only).

### `gate_comparator` (`handle_multiples = TRUE`)
Compares `value_a` `comparison` `value_b` (`=,==,===,!=,<>,<,>,<=,>=`). If TRUE, passes the pipeline
`source` through; if FALSE, returns `when_false_value`. `value_a`/`value_b` may be literals, a source
field name, or `source`. Useful for "pick the bigger/backup value".

### `create_default_paragraph_revision`
Creates default Paragraph entity-reference-revision values during import (for `entity_reference_revisions`
targets). See the class docblock for the exact keys.

## Data parser plugin (`data_parser_plugin: dom`)
For `migrate_plus` `url`/embedded data sources: fetches each source URL over Guzzle and exposes the DOM
for field extraction. Configured under a `dom_config.migration_tools` settings block that lists the
Obtainer `Job`s to run per field (see [../extend/obtainers.md](../extend/obtainers.md)). Throws
`MigrateException` if `dom_config` is missing.

## Source plugin (`source: plugin: url_list`)
Iterates a list of URLs supplied as `urls:` (array) in the source config, one row per URL — the simplest
way to feed a set of pages into a `dom`-parsed scrape. Throws if `urls` is empty.

> Trust note: `dom` and `url_list` issue outbound HTTP to whatever URLs the migration config names.
> Those URLs come from migration YAML authored by a developer/site-builder, not from request input, so
> this is trusted-admin configuration, not an open SSRF surface.
