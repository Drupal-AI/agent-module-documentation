# BAT Event Series — API

Functions in `bat_event_series.module`; entity class `Drupal\bat_event_series\Entity\EventSeries`.

## Series

- `bat_event_series_load($id, $reset = FALSE)`, `bat_event_series_load_multiple($ids, $reset)`.
- `bat_event_series_create($values = [])`.
- `bat_event_series_delete(EventSeries $e)`, `bat_event_series_delete_multiple(array $ids)`.
- `bat_event_series_access($entity, $op, $account)` → base `bat_entity_access()`;
  `bat_event_series_query_bat_event_series_access_alter()` wires the access query rewrite.
- Entity: `getRrule()` returns the stored RRULE string.

## Series types

- `bat_event_series_get_types($name, $reset)`, `bat_event_series_type_load($type)`,
  `bat_event_series_type_access(...)`.
- Field attachment: `bat_event_series_type_add_event_state_reference($bundle)`,
  `_add_event_dates_field($bundle)`, `_add_target_entity_field($bundle, $target_entity_type)`,
  and `bat_event_series_create_event_series_field($bundle)`.

## Recurrence helpers

- `bat_event_series_rrule_date_formatter($date)` — format an RRULE date for display.
- Rule construction/enumeration uses `RRule\RRule` (`rlanvin/php-rrule`) — see
  [../configure/series.md](../configure/series.md). The confirmation modal uses the private tempstore
  `edit_repeating_rule` to stage a preview before regenerating events.
