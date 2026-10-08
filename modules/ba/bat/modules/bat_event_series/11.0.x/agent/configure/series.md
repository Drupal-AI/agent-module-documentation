# BAT Event Series — entity, types, recurrence

## Entity

`bat_event_series` — content entity, base table `event_series`, bundle entity
`bat_event_series_type` (config). Owner-aware (`uid`), has `label`, `type`, and an `rrule` field
(the recurrence rule). `permission_granularity = bundle`; access via base `bat_entity_access()`.
`bat_event_series_entity_insert()` generates the series' events on save.

## Series type (`bat_event_series_type`) config

Schema `bat_event_series.event_series_type.*`: `name`, `type`, `event_granularity`
(`bat_daily`/`bat_hourly`), `target_event_type`. The module attaches state-reference, event-dates and
target-entity fields to each bundle via `bat_event_series_type_add_event_state_reference()`,
`_add_event_dates_field()`, `_add_target_entity_field()`.

Default types (`config/install`):

| Type | Granularity | Target event type |
|---|---|---|
| `availability_daily` | `bat_daily` | `availability_daily` |
| `availability_hourly` | `bat_hourly` | `availability_hourly` |

Also ships `views.view.event_series`.

## Recurrence (RRULE)

The `rrule` field stores an RFC iCal RRULE string produced by `RRule\RRule` (`rlanvin/php-rrule`).
In `EditRepeatingRuleConfirmationModalForm`, form inputs become:

```php
$rrule = new RRule\RRule([
  'FREQ'  => strtoupper($values['repeat_frequency']),  // DAILY / WEEKLY / MONTHLY ...
  'UNTIL' => $values['repeat_until'] . 'T235959Z',
  'DTSTART' => /* start */,
]);
$series->set('rrule', $rrule->rfcString());
```

The rule is enumerated to occurrence dates and each occurrence becomes a `bat_event`.
`bat_event_series_rrule_date_formatter($date)` formats a rule date for display.

## Modal edit / confirm flow

- `entity.bat_event_series.edit_form_modal` → `EditRepeatingRuleModalForm` (perm `administer pages`).
- `entity.bat_event_series.edit_confirmation_form_modal` → `EditRepeatingRuleConfirmationModalForm`
  (perm `administer pages`) — previews how a rule change re-generates events, using the private
  tempstore `edit_repeating_rule`, then confirms.
- `entity.bat_event_series.confirm_edit_form` (`EventSeriesUpdateConfirmForm`) and
  `entity.bat_event_series.delete_events_form` (remove generated events) require
  `_entity_access: bat_event_series.update` / `.delete`.

## Routes (under `/admin/bat/events/event_series`)

Collection (`view any bat_event_series entity`), add `/add[/{event_series_type}]`
(`_event_series_add_access`), canonical/edit/delete (`_entity_access`), series types
`/event-series-types[...]` (`administer bat_event_series_type entities`).
