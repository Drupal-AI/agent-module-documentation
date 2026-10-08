# BAT Calendar Reference — fields, widgets, formatters

## Field types

| Field type id | References | Class |
|---|---|---|
| `bat_calendar_unit_reference` | `bat_unit` | `BatCalendarUnitReference` |
| `bat_calendar_unit_type_reference` | `bat_unit_type` | `BatCalendarUnitTypeReference` |

Add either to any bundle via Field UI. Namespace custom fields (`field_<mod>_*`).

## Widgets

- `bat_calendar_reference_unit_autocomplete` (`BatCalendarReferenceUnitAutocomplete`) — autocomplete a
  unit; can filter selectable units by unit type (`selection_settings['unit_types']`).
- `bat_calendar_reference_unit_type_autocomplete` (`BatCalendarReferenceUnitTypeAutocomplete`).

## Formatters (render the referenced resource's availability)

| Formatter id | Output |
|---|---|
| `bat_calendar_reference_month_view` | FullCalendar month grid. |
| `bat_calendar_reference_timeline_view` | Scheduler timeline. |
| `bat_calendar_reference_raw_formatter` | Raw event data. |

All render through `bat_fullcalendar` (hence the dependency).

## Autocomplete plumbing

Routes (`bat_calendar_reference.routing.yml`, `_access: TRUE`):
`/bat_unit_reference_autocomplete/{target_type}/{selection_handler}/{selection_settings_key}` and
`/bat_event_type_reference_autocomplete/...`. Controllers `BatUnitAutocompleteController` /
`BatEventTypeAutocompleteController` mirror core's `EntityAutocompleteController`: the typed `q` is read
from the request, and the `selection_settings_key` is validated by recomputing
`Crypt::hmacBase64(serialize($settings) . $target_type . $selection_handler, Settings::getHashSalt())`
and comparing — a mismatch or missing key throws `AccessDeniedHttpException`. Matching is delegated to
`BatUnitAutocompleteMatcher` / `BatEventTypeAutocompleteMatcher` (services
`entity.bat_unit_autocomplete_matcher`, `entity.bat_event_type_autocomplete_matcher`). Form elements:
`BatUnitAutocomplete`, `BatEventTypeAutocomplete`.

Because the key is HMAC-signed with the site hash salt, `_access: TRUE` does not expose data an
unauthorized caller could otherwise enumerate — it is core's standard autocomplete access model.
