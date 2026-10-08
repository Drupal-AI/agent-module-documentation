# Calendar Systems — what it swaps & how to extend

Enabling the module transparently replaces several core classes with calendar-aware subclasses.
None of this needs configuration; it happens through alter hooks in `calendar_systems.module`.

## Render elements (`hook_element_info_alter`)

Core date elements are swapped and get the picker library attached:
- `date` → `CalendarSystemsDate` (+ `calendar_systems/picker`)
- `datelist` → `CalendarSystemsDateList`
- `datetime` → `CalendarSystemsDateTime` (+ `calendar_systems/picker`)

The swap rewrites the element's `#process`, `#pre_render`, `#element_validate`, `#value_callback`
callbacks that pointed at the core classes.

## Field widgets (`hook_field_widget_info_alter`)

- `datetime_default` → `CalendarSystemsDateTimeDefaultWidget`
- `datetime_datelist` → `CalendarSystemsDateTimeDatelistWidget`
- `datetime_timestamp` → `CalendarSystemsTimestampDatetimeWidget`
- `datetime_timestamp_no_default` → `CalendarSystemsTimestampDatetimeNoDefaultWidget` (if present)

(Provider is re-declared as `calendar_systems`.) So existing core Date/time fields render in the
active calendar with no field-config change.

## Views plugins

- `hook_views_plugins_filter_alter`: `date` → `CalendarSystemsViewsDate` (filter),
  `datetime` → `CalendarSystemsViewsDateTime`.
- `hook_views_plugins_argument_alter`: `datetime` → `CalendarSystemsDateDate`,
  `datetime_full_date` → `CalendarSystemsDateFullDate`, `date` → `CalendarSystemsViewsDate` (arg),
  `date_fulldate` → `CalendarSystemsViewsFullDate`.

Argument handlers share `CalendarSystemsArgHandlerTrait`, which normalizes Persian digits/words.

## Content-translation handler hacks

`hook_entity_type_alter` swaps the `translation` handler of translatable entity types
(node, comment, term, user profile, block_content, generic) to the matching
`Drupal\calendar_systems\TranslationHack\CalendarSystems*TranslationHandler` so date fields behave
under translation. Only runs when `content_translation` is enabled.

## Adding / changing a calendar

Calendar implementations live in `src/CalendarSystems/` and implement
`CalendarSystemsInterface`. The `persian`/`gregorian` choice is hard-wired in the
`_calendar_systems_factory()` `match`, and the intl-vs-poor-man's switch is the
`CALENDAR_SYSTEMS_USE_INTL` constant (shipped FALSE). Supporting a new calendar therefore means
adding a class and extending that factory (there is no plugin manager to register against).
