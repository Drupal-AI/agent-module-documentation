# Datelist widget third-party settings

Partial Datelist adds **no field, widget, or formatter of its own**. It attaches per-widget
third-party settings to core's two datelist "Select list" widgets and rewrites the rendered form at
build time. All configuration lives on a field-widget component inside an `entity_form_display`
(the *Manage form display* page), namespace `partial_datelist`, key `hidden_datelist_parts`.

## Target widgets

Only these two widget plugin ids are touched (checked in
`src/Hook/PartialDatelistHooks.php`):

| Widget id | Class | Module |
|---|---|---|
| `datetime_datelist` | `Drupal\datetime\Plugin\Field\FieldWidget\DateTimeDatelistWidget` | `datetime` (core) |
| `daterange_datelist` | `Drupal\datetime_range\Plugin\Field\FieldWidget\DateRangeDatelistWidget` | `datetime_range` (core) |

The `daterange_datelist` branch is guarded by `class_exists(...DateRangeDatelistWidget)`, so the
module degrades gracefully when `datetime_range` is not installed. The `datetime_timestamp` widget
and the calendar/HTML5 widget are **not** targeted (no select-list dropdowns).

## Config storage and schema

Schema `field.widget.third_party.partial_datelist` (`config/schema/partial_datelist.schema.yml`)
declares one mapping `hidden_datelist_parts` whose members are six booleans:

```
component.third_party_settings.partial_datelist.hidden_datelist_parts:
  hide_year:   boolean
  hide_month:  boolean
  hide_day:    boolean
  hide_hour:   boolean
  hide_minute: boolean
  hide_second: boolean
```

`TRUE` for a key means that dropdown is hidden. Absent/`FALSE` means it is shown.

## Part → setting map (`PartialDatelistConfig::DATELIST_PARTS`)

`src/PartialDatelistConfig.php` is the single source of truth mapping a `#date_part_order` key to
its hide-setting, label, and the field `datetime_type` contexts where it is offered:

| Part key | Hide setting | Label | Offered when `datetime_type` is |
|---|---|---|---|
| `year` | `hide_year` | Year | `date`, `datetime` |
| `month` | `hide_month` | Month | `date`, `datetime` |
| `day` | `hide_day` | Day | `date`, `datetime` |
| `hour` | `hide_hour` | Hour | `datetime` |
| `minute` | `hide_minute` | Minute | `datetime` |
| `second` | `hide_second` | Second | `datetime` |

So a **Date only** field (`datetime_type: date`) exposes only Year/Month/Day checkboxes; a **Date
and time** field (`datetime_type: datetime`) exposes all six. The settings-form CSS class constant is
`PartialDatelistConfig::DATELIST_SETTINGS_CLASS_NAME` = `partial-datelist-settings`.

## Hooks that implement the feature

All four are attribute-based (`#[Hook(...)]`) methods on
`Drupal\partial_datelist\Hook\PartialDatelistHooks` (registered as an autowired service in
`partial_datelist.services.yml`):

- `field_widget_third_party_settings_form` — for a targeted widget, builds a `checkboxes` element
  `hidden_datelist_parts` (`#title` "Date list visibility settings") listing the parts valid for the
  field's `datetime_type`. `PartialDatelistHooks.php:91`.
- `field_widget_settings_summary_alter` — appends a `Hidden part(s): …` line to the widget summary on
  the *Manage form display* table. `PartialDatelistHooks.php:151`.
- `field_widget_complete_form_alter` — the actual hiding. For each numeric delta in the widget it
  computes `#date_part_order` minus the hidden keys and writes it back on `['value']` and, for
  ranges, `['end_value']`. `PartialDatelistHooks.php:190`.
- `help` (route `help.page.partial_datelist`) — module help text. `PartialDatelistHooks.php:33`.

## Mechanism (form alter)

`fieldWidgetCompleteFormAlter()` reads the widget's stored `hidden_datelist_parts`, builds
`$hidden_parts_keys`, then for every delta:

```php
$valid_date_parts = array_diff($widget[$index]['value']['#date_part_order'], $hidden_parts_keys);
$widget[$index]['value']['#date_part_order'] = $valid_date_parts;
if (isset($widget[$index]['end_value'])) {
  $widget[$index]['end_value']['#date_part_order'] = $valid_date_parts;
}
```

It edits `#date_part_order` (core's datelist render property) only — it does **not** remove the part
from the stored value. A hidden dropdown still contributes a value via core's default datelist
handling (e.g. hiding `second` submits seconds as `0`; a hidden `year` falls back to core's default
year). Choose parts to hide whose defaults are acceptable for the data you collect.

## Set it from code

```php
$display = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article');           // an entity_form_display
$component = $display->getComponent('field_event_date');
// Keep the datelist widget, hide everything but the year:
$component['third_party_settings']['partial_datelist']['hidden_datelist_parts'] = [
  'hide_month'  => TRUE,
  'hide_day'    => TRUE,
  'hide_hour'   => TRUE,
  'hide_minute' => TRUE,
  'hide_second' => TRUE,
];
$display->setComponent('field_event_date', $component)->save();
```

The component's `type` must already be `datetime_datelist` or `daterange_datelist` for the settings
to take effect.

## Upgrade note (`hook_post_update`)

`partial_datelist_post_update_normalize_hidden_datelist_parts` (`partial_datelist.post_update.php`)
walks every `entity_form_display`, and for components using the two target widgets casts any legacy
non-boolean `hidden_datelist_parts` value to a real `bool`. 1.1.x also moved procedural hooks to
`#[Hook]` attributes, so run `drush updatedb` / `update.php` immediately after deploying 1.1.x.
