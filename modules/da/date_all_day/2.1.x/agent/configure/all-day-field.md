<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Set up an "All day" date range field

The module has **no admin settings page**. You use it by choosing its widget on *Manage form
display* and one of its formatters on *Manage display*, for a core **Datetime Range**
(`daterange`) field.

## 1. The field

Any core `daterange` field works — the module adds no field type. Relevant core field settings:

- storage `datetime_type`: `datetime` (date **and** time) — required, otherwise there is no time
  to force to `00:00:00` / `23:59:59`.
- field setting `optional_end_date` (bool): the widget relabels the end date
  "End date (optional)" and un-requires it when TRUE.

## 2. The widget — `daterange_all_day`

Label: **"Date and time range with All day"**. Extends core `DateRangeDefaultWidget`, so it
accepts the same settings (none beyond the base).

```yaml
# core.entity_form_display.<entity>.<bundle>.<form_mode>
content:
  field_event_dates:
    type: daterange_all_day
    weight: 10
    region: content
    settings: {}
    third_party_settings: {}
```

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$fd->setComponent('field_event_dates', [
  'type' => 'daterange_all_day', 'weight' => 10, 'region' => 'content',
  'settings' => [], 'third_party_settings' => [],
])->save();
```

## 3. The formatters

| Formatter id | Label | Extends | `date_only_format` type |
|---|---|---|---|
| `daterange_all_day_default` | Default (All day) | core `DateRangeDefaultFormatter` | select — a **date-format entity id** (default `date_all_day`) |
| `daterange_all_day_custom` | Custom (All day) | core `DateRangeCustomFormatter` | textfield — a **PHP date pattern** (default `date_all_day`, so set it to e.g. `Y-m-d`) |
| `daterange_all_day_plain` | Plain (All day) **(DEPRECATED)** | core `DateRangePlainFormatter` | none (no extra setting) |

All three keep every setting of their core parent (`format_type` / `date_format`,
`separator`, `timezone_override`, `from_to` where the parent has it) and add `date_only_format`,
which is used **instead of** the normal format when the item is all-day.

```yaml
# core.entity_view_display.<entity>.<bundle>.<view_mode>
content:
  field_event_dates:
    type: daterange_all_day_default
    label: above
    weight: 10
    region: content
    settings:
      timezone_override: ''
      format_type: medium          # used for timed ranges
      separator: '-'
      from_to: both_times
      date_only_format: date_all_day   # used for all-day ranges
    third_party_settings: {}
```

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_event_dates');
$vd->setComponent('field_event_dates', [
  'type' => 'daterange_all_day_default', 'label' => 'above',
  'weight' => $c['weight'] ?? 10, 'region' => 'content',
  'settings' => [
    'timezone_override' => '', 'format_type' => 'medium', 'separator' => '-',
    'date_only_format' => 'date_all_day',
  ],
  'third_party_settings' => [],
])->save();
```

## The `date_all_day` date format

`config/install/core.date_format.date_all_day.yml` installs a **locked** date format:

```yaml
id: date_all_day
label: 'Date all day'
locked: true
pattern: 'Y-m-d'
```

It is the default of `date_only_format` on the Default and Custom formatters. Note the Custom
formatter treats `date_only_format` as a **raw PHP pattern**, so leaving the literal default
`date_all_day` there produces nonsense — change it (e.g. to `Y-m-d` or `l j F Y`).

## Read it back

```bash
drush cget core.entity_form_display.node.article.default content.field_event_dates
drush cget core.entity_view_display.node.article.default content.field_event_dates
```

Find every display using the module:

```bash
drush php:eval 'foreach (["entity_form_display","entity_view_display"] as $s) {
  foreach (\Drupal::entityTypeManager()->getStorage($s)->loadMultiple() as $d) {
    foreach ($d->getComponents() as $n => $c) {
      if (str_starts_with($c["type"] ?? "", "daterange_all_day")) { print "$s " . $d->id() . " :: $n = " . $c["type"] . "\n"; }
    }
  }
}'
```

## Via the UI

1. Add a **Date range** field with type *Date and time* to your bundle.
2. *Manage form display* → set the widget to **Date and time range with All day**.
3. *Manage display* → set the format to **Default (All day)** (or Custom (All day)); open the cog
   and pick the **Date only format** used when "All day" is on.
4. On the entity form, ticking **All day** hides both time inputs and forces `00:00` / `23:59:59`.
