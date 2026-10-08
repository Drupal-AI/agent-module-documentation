<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Time Field (simple_time_field) — agent index

A **time-of-day** field type (`HH:MM` or `HH:MM:SS`, no date, no stored timezone) for any
fieldable entity. Ships one widget, four formatters, a reusable HTML5-time form element, a
`TimeHelper` utility, and an optional Feeds target. Depends only on core `field`.
Core `^10 || ^11`.

- **No settings page** — everything is configured per field in the Field UI (`configure` = null).
- Defines no routes, no permissions, no drush commands, no plugin *types* (only plugin instances).
- Provides config schema (field / widget / formatter settings).

Solution docs:
- **Add / configure the Time field, its storage & widget** → [fields/time-field.md](fields/time-field.md)
- **Choose how a stored time is displayed** → [fields/formatters.md](fields/formatters.md)
- **Reuse the time form element, TimeHelper, or Feeds import** → [api/reusable.md](api/reusable.md)

Key facts (real machine names):
- Field type: `simple_time_type` (class `SimpleTimeFieldItem`); default widget `simple_time_widget`,
  default formatter `simple_time_formatter`, category "General".
- Storage: single `value` column, `varchar(8)`, indexed, nullable — the literal `HH:MM`/`HH:MM:SS`
  string (NOT seconds-since-midnight).
- Field setting: `with_seconds` (bool, default FALSE).
- Widget `simple_time_widget` settings: `min`, `max` (time strings), `step` (seconds).
- Formatters: `simple_time_formatter` (configurable), `simple_time_formatter_12h_lower`,
  `simple_time_formatter_12h_upper`, `simple_time_formatter_24h`.
- Form element: `simple_time_field_element` (class `Element\SimpleTimeField`).
- Feeds target id: `simple_time_field`. Utility: `Drupal\simple_time_field\Utility\TimeHelper`.
- Config schema keys: `field.field_settings.simple_time_type`,
  `field.widget.settings.simple_time_widget`, `field.formatter.settings.simple_time_formatter`.
