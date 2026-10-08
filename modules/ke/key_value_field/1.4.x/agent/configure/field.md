<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field types, widgets, formatter & settings

The module has **no admin settings page** and no `configure` route. You add and configure it
per field on a bundle (e.g. *Structure → Content types → Article → Manage fields → Add field*,
category **"Key / Value"**), then tune the widget on *Manage form display* and the formatter on
*Manage display*.

## Field types

| Id | Label | Extends | Default widget | Value |
|---|---|---|---|---|
| `key_value` | Key / Value (plain) | `StringItem` | `key_value_textfield` | plain text |
| `key_value_long` | Key / Value (long) | `TextLongItem` | `key_value_textarea` | formatted (text format) |

Both default to the `key_value` formatter and expose properties `key`, `value`, `description`.

## Storage settings (`field.storage.<entity>.<field>` → `settings`)

| Key | Type | Default | Notes |
|---|---|---|---|
| `key_max_length` | int | 255 | length of the (indexed) `key` DB column; locked once data exists |
| `key_is_ascii` | bool | false | true → `varchar_ascii` key column |
| `max_length`, `is_ascii`, `case_sensitive` | | (from `StringItem`) | plain `key_value` only |

`key_value_long` field settings add `default_format` (a text-format id) applied to new items.

## Widget settings (`key_value_textfield` / `key_value_textarea`)

`key_label` (default "Key"), `key_size` (default 60), `key_placeholder`, `value_label`
(default "Value"), `description_enabled` (default true), `description_label`
(default "Description"), `description_rows` (default 5), `description_placeholder`. The textarea
widget also inherits `rows`/`placeholder` (relabelled "Value Rows" / "Value Placeholder").
When `description_enabled` is false the description textarea is removed from the widget.

## Formatter settings (`key_value`)

| Key | Type | Default | Effect |
|---|---|---|---|
| `value_only` | bool | false | true renders only the value; false renders `key : value` |

Read/write from config, e.g.:

```bash
drush cget field.storage.node.field_specs
drush cget core.entity_view_display.node.article.default field_specs
```

## Required-key behavior

The `key` sub-field is not unconditionally required. A `#states` rule plus the
`validateKeyElement()` handler make it required **only when the value is non-empty**, so a
wholly empty item stays valid (and is treated as empty via `isEmpty()`).
