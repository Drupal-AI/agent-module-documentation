<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datetime Range Timezone — agent index

Adds a **`daterange_timezone`** field type (extends core Datetime Range) that stores a
per-value **timezone** and displays the range in that timezone. Ships a widget and two
formatters. Depends on `datetime_range`. No settings form (`configure: null`), no permissions,
no Drush.

- **Add/configure the field, widget, and the two formatters (settings: `separator`, `format_type`, `display_timezone`, `date_field`)** →
  [configure/field.md](configure/field.md)
- **Storage/behavior details and the Token integration (`start_date`/`end_date` format tokens)** →
  [api/tokens.md](api/tokens.md)

Key facts:
- Field type `daterange_timezone` = `DateRangeItem` + a `timezone` varchar(255) column/property.
- Widget `daterange_timezone` (works on `daterange` too) adds a **Timezone** select; entered dates are treated as that timezone, then stored as UTC.
- Formatters: `daterange_timezone` (default, Twig `datetime-range-timezone.html.twig`) and `daterange_timezone_single_date` (one endpoint via `date_field`).
- Config schema ids: `field.formatter.settings.daterange_timezone`, `field.formatter.settings.daterange_timezone_single_date`, `field.storage_settings.daterange_timezone`.
