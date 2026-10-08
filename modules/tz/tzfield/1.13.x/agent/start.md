<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Time Zone (tzfield) — agent index

Defines a **`tzfield`** field type storing a tz-database identifier (e.g. `Europe/London`) in a
single indexed `value` varchar(50) column. Ships two widgets and one extra formatter; no
configure route, no permissions, no Drush, no services. State is normal field config +
per-field settings on the `field.field.*` config entity.

- **Add the field, its settings, widgets, formatters, and how to script it** →
  [configure/field.md](configure/field.md)

Key facts:
- Field type id `tzfield`; `default_widget = tzfield_default`, `default_formatter = basic_string`.
- Widgets: `tzfield_default` (region-grouped select), `tzfield_offset` (sorted by current UTC
  offset).
- Formatters: core `basic_string` (raw identifier, default) and `tzfield_date`
  ("Formatted current date", setting `format`, default `T`).
- Per-field settings (`field.field_settings.tzfield`): `exclude` (list of zones),
  `default_site` (bool), `default_user` (bool). Allowed values from
  `\DateTimeZone::listIdentifiers()` (implements `OptionsProviderInterface`).
- Also provides a `migrate` field plugin id `tzfield`.
