# Configuring Time Field

The module has **no global admin page and no permissions**. You configure it entirely
per field through Field UI (Manage fields / Manage form display / Manage display), or in
exported field/entity-form/entity-view-display config YAML.

## Field types

| Field type id | Columns | Notes |
|---|---|---|
| `time` | `value` (int, unsigned, size small, required) | seconds past midnight, 0–86400. Indexed. |
| `time_range` | `from` (int, required), `to` (int, **nullable**) | open-ended range allowed when `to` is empty. Indexed on `(from, to)`. |

Both belong to the field-type category **Time** (`time_field.field_type_categories.yml`).
`time`'s default value can be set to "now" — see below.

## Widget settings

Widgets `time_widget` (for `time`) and `time_range_widget` (for `time_range`) render a
native HTML5 `<input type="time">`. Both share these settings
(`field.widget.settings.time_widget` / `...time_range_widget`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | boolean | `false` | Add a seconds parameter to the input (shows/collects seconds). |
| `step` | integer | `5` | Seconds step for the input's `step` attribute; only applies when `enabled` is on. |

The range widget renders two inputs labelled "Start time" / "End time"; at cardinality 1
they are wrapped in a `<fieldset>`. Empty range inputs are saved as `NULL`
(via `massageFormValues`).

## Formatter settings

### `time_formatter` (`field.formatter.settings.time_formatter`)

| Key | Default | Meaning |
|---|---|---|
| `time_format` | `h:i a` | PHP date-format string applied to the stored time. |

### `time_range_formatter` (`field.formatter.settings.time_range_formatter`)

| Key | Default | Meaning |
|---|---|---|
| `time_format` | `h:i a` | PHP date-format string for each of `from`/`to`. |
| `timerange_format` | `start ~ end` | Template with literal `start` and `end` placeholders, replaced by the formatted from/to. Must contain both keys. |

Range display edge cases: if only `to` is set, output is just the `to` time; if only
`from` is set, output is just the `from` time; otherwise `start`/`end` in the template are
substituted.

Supported `time_format` characters (from the formatter settings help):
`a` (am/pm), `A` (AM/PM), `B` (Swatch time), `g` (12h 1–12), `G` (24h 0–23),
`h` (12h 01–12), `H` (24h 00–23), `i` (minutes 00–59), `s` (seconds 00–59).
Any PHP `DateTime::format()` character works since values are formatted through `DateTime`.

## Default value: "current time"

For a `time` field, the field settings form (default value) shows a **"Current time"**
checkbox (`TimeFieldItemList`). When checked, the stored default is the literal `now`,
resolved at entity-create time to `request_time − today-midnight` (seconds past midnight).

## Example: set a field's display format via drush

```bash
# Show a stored time in 24-hour H:i on the node's default view display.
drush config:set core.entity_view_display.node.event.default \
  content.field_start_time.settings.time_format 'H:i' -y
drush cr
```

Storage reminder: values are integer seconds past midnight, so ordering/filtering in Views
works on the raw integer (e.g. `18000` = 05:00:00).
