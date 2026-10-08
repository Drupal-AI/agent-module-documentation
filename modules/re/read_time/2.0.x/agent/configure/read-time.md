<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure read time (per content type)

There is **no global settings page**. Read time is configured on each node type. The module
adds a **Read time** vertical-tab (`details`, `#group => additional_settings`) to the node-type
edit form via `read_time_form_node_type_form_alter()` (in `read_time.module`). Values are saved
as **third-party settings** in the `read_time` namespace on the `node.type.<bundle>` config entity
(entity builder `read_time_form_node_type_form_builder()`).

UI path: `Structure › Content types › <type> › Edit › Read time`.

## Settings (third-party setting keys)

| Form field | TPS key | Type | Default | Notes |
|---|---|---|---|---|
| Enable | `read_time_enable` | bool | `FALSE` | Turns the feature on for the bundle. Also gates the pseudo-field (see below). |
| Fields | `read_time_fields` | array of field machine names | `['body']` | Which fields' words are counted. Options offered: fields of type `text`, `text_long`, `text_with_summary`, plus `entity_reference_revisions` fields targeting `paragraph`. Stored as `array_values(array_filter(...))`. |
| Words per minute | `read_time_wpm` | int (`#min` 1) | `225` | Divisor for the word count. |
| Format | `read_time_format` | string enum | `hour_short` | See format table. |
| Read time display | `read_time_display` | string template | `Read time: :read_time` | Use the `:read_time` token where the formatted value should appear. |

### Format options (`read_time_format`)

| Value | Rendering | Example |
|---|---|---|
| `hour_short` | Hours & minutes, short | `1 hr, 5 mins` |
| `hour_long` | Hours & minutes, long | `1 hour, 5 minutes` |
| `min_short` | Minutes only, short | `65 mins` |
| `min_long` | Minutes only, long | `65 minutes` |

Hours/minutes are computed from the stored minutes value: for the `hour_*` formats
`hours = floor(minutes/60)`, `minutes = ceil(fmod(minutes,60))`; for the `min_*` formats
`minutes = ceil(minutes)`. Plurals are produced with `formatPlural()`; the hour part is omitted
when hours is 0.

## Showing the value — the `read_time` pseudo-field

Enabling the feature exposes an extra/pseudo display field named `read_time` on that bundle
(`hook_entity_extra_field_info`, weight 100, visible by default). Manage its placement/visibility at
`Structure › Content types › <type> › Manage display` (and per view mode). At render,
`read_time_node_view()` outputs it only when **all** hold: `read_time_enable` is on, the display
component `read_time` is enabled for that view mode, and the node has an id. The output is a
`#type => markup` element whose markup is `t(<read_time_display>, [':read_time' => <formatted value>])`.

## Set it via PHP / drush (no config schema shipped)

The module ships no `config/schema`, so set the third-party settings on the node type entity directly:

```php
$type = \Drupal\node\Entity\NodeType::load('article');
$type->setThirdPartySetting('read_time', 'read_time_enable', TRUE);
$type->setThirdPartySetting('read_time', 'read_time_fields', ['body', 'field_sections']);
$type->setThirdPartySetting('read_time', 'read_time_wpm', 200);
$type->setThirdPartySetting('read_time', 'read_time_format', 'min_short');
$type->setThirdPartySetting('read_time', 'read_time_display', ':read_time read');
$type->save();
```

Read them back with `$type->getThirdPartySetting('read_time', 'read_time_wpm', 225)`.
`read_time_defaults()` returns the fallback array (`enable`, `fields`, `wpm`, `format`, `display`).
Uninstalling the module removes all five keys from every node type (`read_time_uninstall()`).

## Operational note

The rendered value is cached in the `read_time` DB table and only refreshed when a node is
inserted/updated (see [api/manager.md](../api/manager.md)). Changing `read_time_wpm` or
`read_time_fields` does **not** retroactively recompute already-saved nodes until each node is
re-saved (or its cached row is cleared).
