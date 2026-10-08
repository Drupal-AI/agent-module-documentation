# Make a daterange field's end date optional

The module has **no admin settings page** and no `configure` route. You opt in per Date range
field. Enabling `optional_end_date` alone changes nothing until you check the box on a field.

## Turn it on for a field (UI)

1. Enable the module (`drush en optional_end_date -y`). It requires core `datetime_range`.
2. Go to the daterange field's **Storage settings** form
   (**Manage fields → your Date range field → Field settings / Storage settings**).
3. Check **"Optional end date"** and save.

The checkbox is a **field storage setting** named `optional_end_date` (boolean, default
`FALSE`). Because it is a *storage* setting it applies to every instance of that field
storage across bundles.

Config schema (`config/schema/optional_end_date.schema.yml`) adds the key to
`field.storage_settings.daterange`:

```yaml
field.storage_settings.daterange:
  type: field.storage_settings.datetime
  mapping:
    optional_end_date:
      type: boolean
      label: 'Optional end date'
```

Set it in code instead of the UI:

```php
$storage = \Drupal::entityTypeManager()->getStorage('field_storage_config')
  ->load('node.field_event_dates');
$storage->setSetting('optional_end_date', TRUE)->save();
```

## What checking the box does (all in `daterange`, no new field type)

The module swaps core plugin classes via `hook_field_info_alter()`,
`hook_field_widget_info_alter()`, and `hook_field_formatter_info_alter()` — it does **not**
add a new field type, widget, or formatter you select. When `optional_end_date` is TRUE:

- **Field type** (`OptionalEndDateDateRangeItem` extends core `DateRangeItem`):
  `end_value` is set not-required; `isEmpty()` treats a value with only a start date as
  non-empty; the `NotNull` constraint on `end_value` is **not** added (it is only added when
  the setting is off).
- **Widgets** (`daterange_default`, `daterange_datelist`): the End date element gets
  `#required = FALSE` and its title becomes **"End date (optional)"**.
- **Formatters** (`daterange_default`, `daterange_plain`, `daterange_custom`): when the end
  date is empty (or equal to the start), only the start date is rendered — no separator, no
  empty end date.

## Existing fields / database

`hook_install()` runs once on enable and alters existing `daterange` storage so the
`<field>_end_value` DB columns allow NULL. `hook_update_8001()` re-saves daterange field
storage configs whose `optional_end_date` setting is not yet a proper boolean.

## Leaving it required

To keep both dates mandatory (core behavior), simply leave the checkbox **unchecked** — the
`NotNull` constraint on `end_value` stays in place and validation fails on an empty end date.

## Uninstalling

The module notes it mimics Drupal 8.9+ core optional-end-date support; once you rely on
core's implementation you can uninstall this module.
