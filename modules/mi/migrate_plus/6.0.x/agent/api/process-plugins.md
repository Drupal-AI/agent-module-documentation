# Extra process / source / destination plugins

All under `src/Plugin/migrate/`. Reference by `plugin:` id in a migration's `process`,
`source`, or `destination`.

## Process plugins (`process/`)
| Plugin | Purpose |
|---|---|
| `entity_lookup` | Find an existing entity id by field value(s). |
| `entity_generate` | Look up, or create the referenced entity if missing. |
| `entity_value` | Read a field value off a referenced entity. |
| `skip_on_value` | Skip the row/process when a value (does not) match. |
| `str_replace` / `preg_match` / `preg_replace` | String rewriting. |
| `merge` / `array_pop` / `array_shift` / `multiple_values` / `single_value` / `transpose` | Array reshaping. |
| `dom`, `dom_select`, `dom_str_replace`, `dom_remove`, `dom_apply_styles`, `dom_migration_lookup` | Parse and rewrite HTML fragments. |
| `file_blob` | Write a file from a binary blob column. |
| `service` | Call a container service method as a transform. |
| `default_entity_value`, `gate`, `snippet`, `array_template` | Misc helpers. |

Example:
```yaml
process:
  uid:
    plugin: entity_generate
    source: author_name
    entity_type: user
    value_key: name
  body/value:
    plugin: dom_str_replace
    mode: attribute
    xpath: '//a'
    attribute_name: href
    search: 'http://old'
    replace: 'https://new'
```

## Source / destination
- `source: table` (`source/Table.php`) — read rows from any DB table.
- `destination: table` (`destination/Table.php`) — write rows into an arbitrary DB table
  (bypasses the entity system).
- `source: url` — see [../plugins/data-plugins.md](../plugins/data-plugins.md).
