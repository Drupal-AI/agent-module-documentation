# Recurring Events — entities & settings

## Entity types
- `eventseries` — the recurrence rule + shared field values. Bundles = `eventseries_type`. Revisionable,
  translatable. Routes under `/events/...` (add `/events/add/{type}`, view `/events/series/{id}`).
- `eventinstance` — one occurrence, auto-generated. Bundles = `eventinstance_type`. View `/events/{id}`.
- `excluded_dates` / `included_dates` — config entities of dates to skip / force-add across series.

Field values on instances are populated from the series via **field_inheritance** (required dep). The
module ships default inheritances for title and description
(`config/install/field_inheritance.field_inheritance.eventinstance_default_*`).

## Series settings
Form `EventSeriesSettingsForm`. Config `recurring_events.eventseries.config`
(schema `config/schema/recurring_events.schema.yml`; defaults in
`config/install/recurring_events.eventseries.config.yml`):

| Key | Default | Meaning |
|---|---|---|
| `interval` | `30` | Minutes between selectable times in the creation form. |
| `min_time` / `max_time` | `08:00am` / `11:45pm` | Earliest / latest start time offered. |
| `date_format` / `time_format` | `F jS, Y h:iA` / `h:i A` | Display formats. |
| `days` | mon…sun (csv) | Days of week available. |
| `limit` | `10` | Items per page on the series listing. |
| `excludes` / `includes` | `1` / `1` | Enable series-level excluded / included dates. |
| `enabled_fields` | all 6 recur types (csv) | Which recur field types show in the creation form (`consecutive_recurring_date,daily_recurring_date,weekly_recurring_date,monthly_recurring_date,yearly_recurring_date,custom`). |
| `threshold_warning` | `1` | Show a warning when too many instances would be created. |
| `threshold_count` | `200` | Instance count that triggers the warning. |
| `threshold_message` | see install | Warning text (`@total`, `@threshold` tokens). |
| `threshold_prevent_save` | `0` | If 1, block saving a series that exceeds the threshold. |
| `creator_plugin` | `recurring_events_eventinstance_recreator` | `event_instance_creator` plugin used to build instances. |

## Instance settings
Form `EventInstanceSettingsForm`. Config `recurring_events.eventinstance.config`:
`date_format` (`F jS, Y h:iA`), `limit` (`10`).

## Admin routes (base)
Both settings forms live under *Structure → Events*. Excluded/included dates and orphaned-instance
cleanup are also there (see permissions doc for gating). There is no single `configure` route in
info.yml (`configure` is null); use the Structure → Events menu.

Drush:
```
drush cget recurring_events.eventseries.config
drush cset recurring_events.eventseries.config threshold_prevent_save 1
```
