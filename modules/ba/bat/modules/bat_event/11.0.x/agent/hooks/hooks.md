# BAT Event — hooks

Documented in `bat_event.api.php`.

## `hook_bat_event_target_entity_types()`

Return machine names of entity types that BAT events may target and treat as a "Unit". The returned
entity types **must implement** `getEventDefaultValue()` and `formatEventValue()`.

```php
function mymodule_bat_event_target_entity_types() {
  return ['bat_unit'];
}
```
`bat_unit` implements this to register itself as the default target.

## `hook_bat_event_constraints_info()` / `hook_bat_event_constraints_info_alter($constraints_info)`

Define / alter booking constraints (e.g. minimum stay, check-in day) applied when matching units.
Collected by `bat_event_constraints_get_info()` and passed into the calendar matching calls
(`getMatchingUnits`).

## `hook_bat_facets_search_results_alter(&$units, $context)`

Alter the set of units/types returned by an availability-faceted search (used by `bat_facets`).
`$context` includes `types_before_search`, `start_date`, `end_date`, `event_type`, `valid_states`,
`available_unit_count`.

## Access condition hooks

Via the base access query rewrite, `bat_event` also participates in
`hook_bat_entity_access_view_condition[_bat_event]_alter()` (see base
`agent/hooks/hooks.md` / `agent/api/framework.md`).
