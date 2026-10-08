# Hours, Minutes and Seconds — agent index

A **duration field** stored as one integer (`value`, total seconds). No configure route, no
permissions, no Drush, no custom plugin types (it defines core Field API plugins). Config schema
is shipped for every widget/formatter.

Plugin ids at a glance:
- Field type: **`hour_minutes_seconds`** (single nullable `int` column `value`; default widget
  `hour_minutes_seconds_default`, default formatter `hour_minutes_seconds_default_formatter`).
- Widget: **`hour_minutes_seconds_default`**.
- Formatters: **`hour_minutes_seconds_default_formatter`** (live count-up),
  **`hour_minutes_seconds_countdown_formatter`**, **`hour_minutes_seconds_natural_language_formatter`**,
  **`hour_minutes_seconds_iso_duration_formatter`**.
- Service: **`hours_minutes_seconds.hour_minutes_seconds`**. Form element `#type`:
  `hour_minutes_seconds`. Views field handler id: `hour_minutes_seconds`.

Docs:
- **Add the field, widget/formatter/field settings keys, config schema, format strings** →
  [configure/field.md](configure/field.md)
- **Service methods, the reusable form element, the theme hooks** → [api/service.md](api/service.md)
- **`factor_alter` / `format_alter` hooks** → [hooks/alter-hooks.md](hooks/alter-hooks.md)
