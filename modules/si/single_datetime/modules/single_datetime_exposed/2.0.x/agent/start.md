<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Time Exposed Views Filters — agent index

Submodule of **single_datetime**. Auto-attaches the xdan datetimepicker to date-type exposed
Views filters. **No configuration, no settings, no plugin, no service** — one `hook_form_alter`.

- **The form alter, the filter conditions it targets, operator handling, and how to make an
  exposed filter eligible** → [api/exposed-filter.md](api/exposed-filter.md)

Key facts:
- Only file of substance is `single_datetime_exposed.module`:
  `single_datetime_exposed_form_views_exposed_form_alter()`.
- It enhances an exposed filter only when **`plugin_id` is `date` or `search_api_date`** AND
  **`value.type === 'date'`** (absolute-date filters, not relative/offset). It uses
  `\Drupal\single_datetime\AttributeHelper::defaultWidget()` and attaches the
  `single_datetime/datetimepicker` library.
- `between` / `not between` → picker on both `min` and `max` inputs, relabelled "( From )" /
  "( To )"; other operators → picker on the single input.
- Requires **Views** (core) and the parent **single_datetime** module + its xdan library.
- No configure route (`configure: null`); enabling the module is the entire setup.
