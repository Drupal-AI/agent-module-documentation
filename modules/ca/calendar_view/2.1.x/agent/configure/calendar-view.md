<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Building a Calendar View

Calendar View has **no global config form** (`configure` is `null`). Everything is set on a
Views display: pick the calendar **style**, then bind a **date field**.

## Steps (Views UI)

1. Create a View of any entity (e.g. Content). Add a **Format → Calendar by month**
   (`calendar_month`) or **Calendar by week** (`calendar_week`) style.
2. Under **Fields**, add at least one **supported Date field** (see plugins doc for the list),
   e.g. *Content: Authored on* (`created`) or a `datetime`/`daterange` field.
3. Open the style **Settings** and tick that field under **Date fields** (`calendar_fields`).
   Without a selected date field the display renders "Missing calendar field."

## Style options (config key → meaning)

| Key | Meaning | Default |
|---|---|---|
| `calendar_fields` | sequence of View field ids used as the event date(s) | `[]` |
| `calendar_display_rows` | also render the normal row output beneath the calendar | `0` |
| `calendar_weekday_start` | first weekday (0=Sun … 6=Sat; empty = site default) | `1` (Mon) |
| `calendar_sort_order` | `ASC`/`DESC` ordering of events within a day cell | `ASC` |
| `calendar_timestamp` | default date, any strtotime-readable string (e.g. `this month`, `today`, `2025-12-31`); empty = date of first result | `this month` |
| `calendar_title` | table caption; supports `date`/`view`/`site` tokens (e.g. `[date:custom:F Y]`) | `''` |
| `calendar_row_title` | HTML title attribute per rendered result | `''` |
| `calendar_work_week` | **`calendar_week` only** — hide weekend days | `0` |

## The config lives under the display's `style`

In `views.view.*` config the display's `display_options.style` looks like:

```yaml
style:
  type: calendar_month
  options:
    calendar_fields:
      created: created      # keyed by the View field id
    calendar_weekday_start: '1'
    calendar_sort_order: ASC
    calendar_timestamp: today
```

## Build one programmatically (drush php:eval)

Minimal Content-by-month calendar bound to the `created` field:

```php
$view = \Drupal\views\Entity\View::create([
  'id' => 'my_calendar', 'label' => 'My Calendar', 'base_table' => 'node_field_data',
]);
$display = &$view->getDisplay('default');
$display['display_options']['fields']['created'] = [
  'id' => 'created', 'table' => 'node_field_data', 'field' => 'created',
  'entity_type' => 'node', 'entity_field' => 'created', 'plugin_id' => 'field',
];
$display['display_options']['style'] = [
  'type' => 'calendar_month',
  'options' => ['calendar_fields' => ['created' => 'created']],
];
$view->save();
```

## Optional pieces

- **Pager**: set the display pager `type` to `calendar_month` or `calendar_week` for
  previous/next navigation (options: `offset`, `label_format`, `use_previous_next`, `display_reset`).
- **"Jump to" filter**: add the *Calendar View: Jump to* filter (`calendar_view_timestamp`)
  so visitors can navigate to any date; it also reads `?calendar_timestamp=<date>` from the URL.
