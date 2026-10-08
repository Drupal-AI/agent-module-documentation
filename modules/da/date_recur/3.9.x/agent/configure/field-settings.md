<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# Configure a date_recur field

## Add the field

`date_recur` is a normal Field UI field type (label "Recurring date"), so add it like any
field. Its default widget is `date_recur_basic_widget` ("Simple Recurring Date") and default
formatter `date_recur_basic_formatter`. It extends `datetime_range`, so it inherits the
`datetime_type` (date / datetime) storage setting.

Programmatic creation:

```php
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_when',
  'entity_type' => 'node',
  'type' => 'date_recur',
  'settings' => ['datetime_type' => 'datetime', 'rrule_max_length' => 256],
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_when',
  'entity_type' => 'node',
  'bundle' => 'article',
  'settings' => [
    'precreate' => 'P2Y',
    'parts' => ['all' => TRUE, 'frequencies' => []],
  ],
])->save();
```

## Storage settings (`field.storage_settings.date_recur`)

- `datetime_type` — inherited from `datetime_range` (`date` or `datetime`).
- `rrule_max_length` — integer max characters of the stored RRULE (nullable = unlimited).
  Adds a `Length` constraint to the `rrule` property.

## Field (instance) settings (`field.field_settings.date_recur`)

- `precreate` — an ISO-8601 duration (default `P2Y`). For **infinite** rules, occurrences are
  pre-generated into the occurrence cache table this far into the future.
- `parts` — the frequency/part **allow grid** that limits what editors may enter:
  - `parts.all` (bool, default `TRUE`) — allow every frequency and every part.
  - `parts.frequencies` — map of `FREQUENCY => [PART, …]`. Only meaningful when `all` is
    `FALSE`. A frequency present with a non-empty part list is allowed; absent/empty = disabled.
    In the UI each frequency row is `Disabled` / `All parts` / `Specify parts`; "Specify parts"
    stores the chosen part list, "All parts" stores the sentinel part `*`
    (`DateRecurItem::PART_SUPPORTS_ALL`).

Frequencies: `SECONDLY, MINUTELY, HOURLY, DAILY, WEEKLY, MONTHLY, YEARLY`.
Parts: `DTSTART, UNTIL, COUNT, INTERVAL, BYSECOND, BYMINUTE, BYHOUR, BYDAY, BYMONTHDAY,
BYYEARDAY, BYWEEKNO, BYMONTH, BYSETPOS, WKST`. Some combinations are illegal per RFC 5545
(e.g. `BYWEEKNO` only with `YEARLY`); the `DateRecurRuleParts` constraint enforces both the
grid and RFC compatibility (`DateRecurRruleMap::INCOMPATIBLE_PARTS`). Example: to allow only
"every N weeks on chosen weekdays":

```php
'parts' => ['all' => FALSE, 'frequencies' => ['WEEKLY' => ['INTERVAL', 'BYDAY', 'COUNT', 'UNTIL']]],
```

## Widget & formatter settings

Widget `date_recur_basic_widget` (settings inherit `daterange_default`): start/end date fields
plus a raw RRULE textarea, filtered to the allowed parts.

Formatter `date_recur_basic_formatter` settings:
`show_next` (int, default 5 — how many upcoming occurrences to list), `count_per_item`
(bool, default TRUE), `occurrence_format_type` / `same_end_date_format_type` (core date-format
machine names, default `medium`), and `interpreter` (id of a `date_recur_interpreter` config
entity used to print the human-readable rule; NULL = none).

## Interpreters (the module's config UI)

`configure` route = `entity.date_recur_interpreter.collection` →
**/admin/config/regional/recurring-date-interpreters** (permission
`date_recur manage interpreters`). Interpreters are `date_recur_interpreter` **config
entities** turning an RRULE into text; the module ships the RL plugin and an optional
`default_interpreter` (`config/optional`). Create one with Drush:

```bash
drush php:eval '\Drupal\date_recur\Entity\DateRecurInterpreter::create([
  "id" => "my_interpreter", "label" => "My interpreter", "plugin" => "rl",
  "settings" => ["show_start_date" => TRUE, "show_until" => TRUE, "date_format" => "long", "show_infinite" => TRUE],
])->save();'
```

See [../plugins/interpreters.md](../plugins/interpreters.md) for writing an interpreter plugin.

## Views

The module registers a `date_recur_occurrences_filter` Views filter (filter occurrences by
date, with `value_granularity`/`value_min`/`value_max`) and a `date_recur_date` Views field,
both operating on the generated per-field occurrence table.
