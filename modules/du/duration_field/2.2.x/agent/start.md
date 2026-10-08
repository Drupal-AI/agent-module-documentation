<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Duration Field — agent index

Adds a Field API field type **`duration`** (+ widget + 3 formatters) and two Form API
elements (**`duration`**, **`granularity`**) for collecting a length of time. Stored as an
ISO 8601 duration string plus a `seconds` column (for math/queries) and a `weeks` column.
**No config route** (`configure: null`), **no permissions** — configured per field.

- **Add/configure a duration field: field type, granularity, weeks, widget, formatters** →
  [configure/field.md](configure/field.md)
- **Services & data model, the `duration`/`granularity` Form API elements, filtering by duration string** →
  [api/services.md](api/services.md)
- **Drush command `duration_field:prepare_uninstall`** → [drush/commands.md](drush/commands.md)
- **Custom separators/labels for the Human Friendly formatter (two hooks)** →
  [hooks/separators.md](hooks/separators.md)

Key facts:
- Field id `duration`; widget `duration_widget`; formatters `duration_human_display` (default),
  `duration_string_display`, `duration_time_display`.
- Columns: `duration` (varchar ISO 8601, e.g. `P1Y2M10DT2H30M`), `seconds` (bigint),
  `weeks` (int). Empty duration = `P0M`. `mainPropertyName()` = `duration`.
- Field settings: `granularity` (default `y:m:d:h:i:s`) and `include_weeks` (bool).
- Services: `duration_field.service` (`DurationService`), `duration_field.granularity.service`
  (`GranularityService`).
