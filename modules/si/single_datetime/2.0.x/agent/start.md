<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single DateTimePicker — agent index

A single-input date/time **field widget** set (xdan jQuery DateTimePicker). No settings form,
no `configure` route, no permissions, no Drush, no plugin types of its own. Its only persistent
state is the **widget type + widget settings** stored on a field component in an
`entity_form_display` config entity.

Widgets it registers:
- `single_date_time_widget` → `datetime` fields
- `single_date_time_timestamp_widget` → `timestamp` / `created` fields
- `single_date_time_range_widget` → `daterange` fields (in the **single_datetime_range** submodule)

- **Assign the widget to a field + the full list of widget settings** →
  [configure/widget-settings.md](configure/widget-settings.md)
- **The `single_date_time` Form API element & `AttributeHelper` (custom forms / plain textfields)** →
  [api/form-element.md](api/form-element.md)

Submodules (own docs): `single_datetime_exposed` (auto-attach picker to Views exposed date
filters), `single_datetime_range` (daterange widget). Requires the external
`/libraries/jquery-datetimepicker` JS/CSS library to actually render the picker.
