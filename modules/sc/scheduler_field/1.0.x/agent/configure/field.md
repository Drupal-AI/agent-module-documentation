# Scheduler Field — field type, widget, formatter, Views

No global settings page and no permissions. You add a **Scheduler field** on *Manage fields*, choose a
default scheduler type in *field storage settings*, then configure the widget on *Manage form display*.

## Field type `scheduler_field` (`src/Plugin/Field/FieldType/SchedulerFieldItem.php`)

- Extends `datetime_range`'s `DateRangeItem`; uses `DateRangeFieldItemList`.
- Columns: inherited `value` + `end_value` (datetime range) **plus** `scheduler_type` (`varchar(255)`,
  indexed). `end_value` is made **not required**.
- Storage setting `scheduler_type` (default `SchedulerFieldItem::SCHEDULER_TYPE_DISABLED`) picks the
  default plugin; set on the *field storage settings* form via a select of all plugin definitions
  (disabled once the field has data).
- `datetime_type` storage setting is inherited from date-range (`date` vs `datetime`).
- `getSchedulerTypeOptions($entity)` returns the plugin options **filtered** by each plugin's
  `isAvailableForEntity()`.

## Widget `scheduler_field_default` (`extends DateRangeDefaultWidget`)

Adds a `scheduler_type` `<select>` (weight -10) to the date-range inputs. Settings (schema
`field.widget.settings.scheduler_field_default`):

| Setting | Default | Effect |
|---|---|---|
| `show_end_date` | `TRUE` | When off, hides the `end_value` input and relabels start as "Date". |
| `show_type_selector` | `TRUE` | When off, sets `#access = FALSE` on the scheduler-type select (uses the field's default type). |

Element validator `setStartDateDependingOnEndDate()` auto-sets an empty start date to "now" when an end
date in the future is supplied.

## Formatter `scheduler_field_default` (`extends DateRangeDefaultFormatter`)

Renders start (and end, if different) as `<time>` elements with a separator — standard date-range output
plus `scheduler_field`-aware handling of an empty/equal end date. Formatter settings schema reuses
`field.formatter.settings.daterange_default`.

## Views integration (`scheduler_field.module::scheduler_field_field_views_data()`)

Builds on `datetime` views data for `value`/`end_value`, then exposes the `scheduler_type` column with:

- **Field** `scheduler_type` (`src/Plugin/views/field/SchedulerType.php`) — option `display_name` shows
  the plugin's human label instead of the machine id.
- **Filter** `scheduler_type` (`InOperator`) — value options are the plugin ids/names.
- **Argument** `string_list_field` (core) on the scheduler type.

## Add the field with Drush (example)

```php
// drush php:eval — add a scheduler field to node.article defaulting to the publication plugin
\Drupal\field\Entity\FieldStorageConfig::create([
  'field_name' => 'field_schedule',
  'entity_type' => 'node',
  'type' => 'scheduler_field',
  'settings' => ['datetime_type' => 'datetime', 'scheduler_type' => 'scheduler_field_type_publication'],
])->save();
\Drupal\field\Entity\FieldConfig::create([
  'field_name' => 'field_schedule', 'entity_type' => 'node', 'bundle' => 'article',
  'label' => 'Publish schedule',
])->save();
```

Then run cron (`drush cron`) periodically so schedules execute — see
[../plugins/scheduler-field-type.md](../plugins/scheduler-field-type.md).
