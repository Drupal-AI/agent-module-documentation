# Field Limiter — the formatter

## Pick it

*Structure → Content types → [type] → Manage display* (any `entity_view_display`). Set a multi-value
field's **Format** to **"Limit the number of rendered items"** (`field_limiter`). Because it extends
`field_formatter`'s `FieldWrapperBase`, the settings form (gear icon) asks you to choose the **wrapped
formatter** — any formatter valid for that field type — plus its settings, then adds two fields:

| Setting | Key | Default | Meaning |
|---|---|---|---|
| Skip items | `offset` | 0 | Number of leading values to drop. |
| Display items | `limit` | 0 | Number of values to show; **0 = show all remaining**. |

Both are required, `#min = 0`. The summary reads e.g. *"Limited to 3 values, starting at 1."* (offset
is shown 1-based in the summary).

## Cardinality rule

`settingsForm()` returns `[]` when `getCardinality() == 1`, so on single-value fields the limiter adds
no options and does nothing useful — only use it on fields with cardinality > 1 (or unlimited, `-1`).

## All field types, not just entity_reference

The plugin annotation lists `field_types = { "entity_reference" }`, but the module's
`hook_field_formatter_info_alter()` overwrites that with the full list of registered field types:

```php
$info['field_limiter']['field_types'] = array_keys(
  \Drupal::service('plugin.manager.field.field_type')->getDefinitions()
);
```

So it appears as a format option on text, number, link, image, media, taxonomy reference, etc.

## How rendering works (viewElements)

- `$offset = getSetting('offset')`; `$limit = getSetting('limit') == 0 ? NULL : getSetting('limit')`.
- `array_slice($field_values, $offset, $limit)` reduces the item list, then the wrapped formatter is
  run over the reduced `$items` (`getFieldOutput()`), and only those children are returned.
- With a concrete limit it loops, backfilling from later items if the wrapped formatter renders fewer
  elements than requested, until `limit` elements are produced or values run out.

## Where the config lives (config entity / schema)

Stored in the display component, e.g.:

```yaml
# core.entity_view_display.node.<bundle>.<view_mode> → content.<field>.settings
type: field_limiter
settings:
  type: <wrapped_formatter_id>      # the formatter being wrapped
  settings: { ... }                 # that formatter's own settings
  offset: 0
  limit: 3
```

Schema: `field.formatter.settings.field_limiter` (maps `type`, `settings` →
`field.formatter.settings.[%parent.type]`, `offset`, `limit`).

## Dependency

Requires the contrib **`field_formatter`** module (info `dependencies: field_formatter:field_formatter`),
which provides `FieldWrapperBase`. Enable it too: `drush en field_formatter field_limiter -y`.
