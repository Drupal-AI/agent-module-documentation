# Starrating — agent index

A `starrating` **field type** (tiny int) + widget + three formatters that render an
editor-entered score as icons or text. **No end-user voting, no admin config page, no routes,
permissions, services, or Drush.** Requires core `field`. `configure` = null (everything is
per-field via Field UI / config).

- **Add the field, set `max_value`, choose a widget & formatter, icon/color/fill options** →
  [configure/field-setup.md](configure/field-setup.md)
- **The `starrating_formatter` theme hook, its template, and the per-icon CSS libraries** →
  [theming/render.md](theming/render.md)

Key facts:
- Field type `starrating` (`default_widget = starrating`, `default_formatter = starrating`);
  storage is one `int`/`tiny` `value` column. Empty = value 0.
- Field setting: `max_value` (1–10, default 10).
- Formatters: `starrating` (icons), `starrating_value` (raw number), `starrating_value_rating`
  (`rate/max`, e.g. `8/10`).
- Icon formatter settings: `icon_type` (17 sets), `icon_color` (1–8), `fill_blank` (bool).
