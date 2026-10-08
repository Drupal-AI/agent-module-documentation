BAT Calendar Reference lets any fieldable entity reference a BAT unit or unit type and display that resource's availability calendar inline — a month view, a timeline view, or raw event data — so you can, for example, put a bookable room's live availability calendar on a node.

---

The module provides two field types — `bat_calendar_unit_reference` (reference a `bat_unit`) and
`bat_calendar_unit_type_reference` (reference a `bat_unit_type`) — with matching autocomplete widgets
(`bat_calendar_reference_unit_autocomplete`, `bat_calendar_reference_unit_type_autocomplete`) and three
formatters that render the referenced resource's availability via BAT Fullcalendar:
`bat_calendar_reference_month_view` (a FullCalendar month grid), `bat_calendar_reference_timeline_view`
(a scheduler timeline), and `bat_calendar_reference_raw_formatter` (raw event data). Autocomplete is
served by dedicated routes/controllers (`BatUnitAutocompleteController`,
`BatEventTypeAutocompleteController`) with custom matchers (`BatUnitAutocompleteMatcher`,
`BatEventTypeAutocompleteMatcher`) and form elements (`BatUnitAutocomplete`, `BatEventTypeAutocomplete`)
that can filter units by unit type; the controllers reproduce Drupal core's autocomplete security
pattern (an HMAC-signed selection-settings key validated against `Settings::getHashSalt()`). Because it
renders through Fullcalendar it depends on `bat_fullcalendar`. Add a calendar-reference field to any
bundle to surface BAT availability wherever you need it.

---

- Reference a specific bookable unit (`bat_unit`) from any fieldable entity.
- Reference a unit type (`bat_unit_type`) from any fieldable entity.
- Display a referenced unit's availability as a FullCalendar month view.
- Display availability as a scheduler timeline view.
- Output raw event data for a referenced resource (`raw_formatter`).
- Show a bookable room's live calendar on a node, block, or other content.
- Autocomplete unit references with a type-aware matcher (filter by unit type).
- Autocomplete unit-type references.
- Filter selectable units in the widget to a configured set of unit types.
- Embed availability without building a custom calendar block.
- Reuse the BAT Fullcalendar rendering for arbitrary entities.
- Build a catalog/landing page where each item shows its own availability.
- Attach the field to a Commerce product, node, or paragraph.
- Present availability read-only to site visitors.
- Combine a description entity with its bookable resource's calendar.
- Drive the calendar off the same BAT event tables the admin manages.
- Provide month and timeline display options per field instance.
- Keep autocomplete access-safe via core's HMAC selection-settings-key check.
