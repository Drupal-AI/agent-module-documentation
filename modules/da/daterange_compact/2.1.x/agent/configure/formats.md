<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Compact date range formats & the field formatter

Two things to configure: **format config entities** (the compact rules) and the **field
display** that uses the `daterange_compact` formatter.

## The `daterange_compact_format` config entity

Config prefix `daterange_compact.format.<id>`; managed at *Configuration → Regional and
language → Compact date and time range formats*
(`entity.daterange_compact_format.collection`, `admin_permission = administer site
configuration`). Two are preinstalled: **`medium_date`** and **`medium_datetime`**.

Keys (all patterns use PHP date-format tokens, like core date formats):

| Key | Type | Purpose |
|---|---|---|
| `id`, `label` | string | Machine id / human label. |
| `default_pattern` | date_format | **Required.** Used when start == end, or no compacter case applies. |
| `default_separator` | string | Separator between the two ends in the default case (e.g. ` – `). |
| `same_day_start_pattern` / `same_day_end_pattern` | date_format | Optional; used when start & end fall on the same day. |
| `same_day_separator` | string | Separator for the same-day case (falls back to `default_separator`). |
| `same_day_omit_duplicate_ampm` | bool | Drop a duplicated am/pm in a same-day time range. |
| `same_month_start_pattern` / `same_month_end_pattern` | date_format | Optional; same-month case (avoid repeating the month). |
| `same_month_separator` | string | Separator for the same-month case. |
| `same_year_start_pattern` / `same_year_end_pattern` | date_format | Optional; same-year case (avoid repeating the year). |
| `same_year_separator` | string | Separator for the same-year case. |
| `zero_minutes_omit` | bool | Omit minutes when they are zero. |
| `zero_minutes_omit_pattern` | string | The token to strip when minutes are zero (default `:i`). |

A same-* case is only used when at least one of its start/end patterns is non-empty; otherwise
the module falls back to the default pattern (see `DateRangeCompactFormat::getSame*Patterns()`).

### Example (the shipped `medium_date`)

```yaml
id: medium_date
label: 'Medium (date only)'
default_pattern: 'j F Y'
default_separator: ' – '
same_month_start_pattern: j
same_month_end_pattern: 'j F Y'
same_month_separator: –
same_year_start_pattern: 'j F'
same_year_end_pattern: 'j F Y'
```

### Manage via UI

1. Go to `/admin/config/regional/daterange-compact-format`.
2. **Add format**, set the label + default pattern, then optionally fill the same-day /
   same-month / same-year patterns and separators. **Save**.

### Scriptable (drush php:eval)

```php
$storage = \Drupal::entityTypeManager()->getStorage('daterange_compact_format');
$storage->create([
  'id' => 'event_range', 'label' => 'Event range',
  'default_pattern' => 'j F Y', 'default_separator' => ' to ',
  'same_month_start_pattern' => 'j', 'same_month_end_pattern' => 'j F Y', 'same_month_separator' => '–',
])->save();
```

Read back: `drush cget daterange_compact.format.event_range` (or `config:get`).

## Using the formatter on a field

Formatter id **`daterange_compact`** ("Compact"), for field types `daterange`, `datetime`,
`timestamp`. Setting `daterange_compact_format` (default `medium_date`) chooses the format
entity.

- UI: *Manage display* → set the field's format to **Compact** → in its settings pick a
  **Format** from the configured list.
- Config: `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type: daterange_compact`, `content.<field>.settings.daterange_compact_format:
  <format_id>`.

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_dates', [
  'type' => 'daterange_compact',
  'settings' => ['daterange_compact_format' => 'medium_datetime'],
  'label' => 'above',
])->save();
```

## Config schema

`config/schema/daterange_compact.schema.yml`: `daterange_compact.format.*` (config_entity, all
keys above) and `field.formatter.settings.daterange_compact` (`daterange_compact_format`
string).
