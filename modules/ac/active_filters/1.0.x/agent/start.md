# Active Filters — agent index

A Views **area** plugin (`views.area.active_filters`, added to any display's Header/Footer) that turns
the current exposed-filter selections into removable "active filter" chips. Depends on core `views`.
No admin config page (`configure` null), no permissions, no Drush. Config schema for the area options.
Not a new plugin *type* — it implements core's Views area handler.

- **Add and configure the area: all per-area and per-exposed-filter options, value rewriting, where
  settings are stored** → [configure/views-area.md](configure/views-area.md)
- **Theme the output: theme hooks, template suggestions, `data-active-filter-*` attributes, the remove
  JS and `activeFilterRemove` custom hook, CSS libraries** → [theming/theming.md](theming/theming.md)
- **Alter active filters in code before render: `hook_active_filters_alter()` and the value objects** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Add via Views UI: *Add* → *Header* or *Footer* → **Global: Active Filters**. Stored in the display's
  `views.area.active_filters` config (`title`, `hide_title`, `grouped`, `clear_text`, and per-filter
  `filters.<id>.{enable,removable,rewrite}`).
- Active values come from `getExposedInput() + exposed_raw_input` (request data) and are output only
  through Twig autoescaping / `Attribute` objects — no raw-markup sink.
- Services: `active_filters.factory` (builds `ActiveFilter`/`ActiveFilterGroup` value objects) and
  `active_filters.builder` (builds render arrays).
