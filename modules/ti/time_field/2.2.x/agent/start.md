# Time Field — agent index

Adds two field types for time-of-day values, stored as integer seconds past midnight:

- `time` — one time; widget `time_widget`, formatter `time_formatter`.
- `time_range` — start/end pair (`from`, `to`; `to` nullable); widget `time_range_widget`, formatter `time_range_formatter`.

No admin settings page and no permissions — everything is per-field via Field UI.
Depends only on core `datetime`. Requires nothing outside core.

- [Configure fields, widgets & formatters](configure/time_field.md) — settings keys, seconds/step, output format strings, current-time default.
- [Programmatic API & integrations](api/time_field.md) — the `Time` value object, `#type => 'time'` form element, Token support, Feeds target, validation constraint, storage/data model.
