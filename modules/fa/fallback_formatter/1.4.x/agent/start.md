# Fallback Formatter — agent index

One field formatter, **"Fallback"** (`@FieldFormatter id="fallback"`), that runs an ordered list of the
field type's other formatters and, per delta, uses the first one that returns output. Available only for
field types that already have ≥2 formatters. No settings page (`configure` null), no permissions, no
Drush. Provides a config schema.

- **Choose it on Manage display, enable/order sub-formatters, settings storage, render behaviour** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Enabled via `hook_field_formatter_info_alter` only where a field type has >1 formatter.
- Settings stored under `field.formatter.settings.fallback` → `formatters` sequence
  (`status`, `weight`, `formatter`, nested `settings`).
- `fallback` cannot fall back to itself; also blocked as an Entity Embed display plugin.
