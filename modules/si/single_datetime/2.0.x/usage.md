<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Single DateTimePicker provides a single-input date/time field widget (and a `single_date_time` Form API element) backed by the xdan jQuery DateTimePicker library, replacing core's separate date + time HTML5 inputs with one calendar+clock popup.

---

The module registers Field widget plugins for core date fields: `single_date_time_widget` for `datetime` fields, `single_date_time_timestamp_widget` for `timestamp`/`created` fields, and (via the `single_datetime_range` submodule) `single_date_time_range_widget` for `daterange` fields. You assign one of these widgets on an entity's *Manage form display* page; there is no global settings form and no `configure` route. Each widget shares a rich set of per-widget settings defined in `SingleDateTimeBase::defaultSettings()` — `hour_format` (12h/24h), `allow_seconds`, `allow_times` (minute granularity 5/10/15/30/60), `allowed_hours`, `disable_days` (weekdays), `exclude_date` (specific `d.m.Y` dates), `inline`, `mask`, `datetimepicker_theme` (default/dark), `start_date`, `min_date`, `max_date`, `year_start`, `year_end`, and `allow_blank`. These settings are stored on the widget component inside the `entity_form_display` config entity and are passed to the browser as `data-*` attributes read by `js/drupal.single_datetime.js`. The `single_datetime_exposed` submodule attaches the same picker to Views exposed date filters automatically, and the `\Drupal\single_datetime\AttributeHelper` helper lets you attach the picker to arbitrary Form API elements. The module requires the external xdan datetimepicker JS/CSS library installed at `/libraries/jquery-datetimepicker`; without it the widget falls back to a plain text input.

---

- Replace core's two-box date + time inputs with a single popup calendar/clock on a `datetime` field.
- Use `single_date_time_timestamp_widget` to edit a `timestamp` or the node `created` field with the picker.
- Constrain time entry to whole 15-minute slots via the `allow_times` minutes-granularity setting.
- Switch a booking field to 12-hour AM/PM entry with `hour_format: 12h`.
- Force seconds to a default `00` with the `allow_seconds` setting.
- Restrict selectable hours to business hours (e.g. `8,9,...,17`) with `allowed_hours`.
- Grey out weekends in the calendar with `disable_days` (Saturday/Sunday).
- Block specific holiday dates using `exclude_date` (one `d.m.Y` per line).
- Render the picker inline (always visible) instead of a popup with `inline`.
- Add an input mask (`__.__.____`) to guide manual typing with `mask`.
- Apply a dark colour scheme via `datetimepicker_theme: dark`.
- Limit the minimum/maximum pickable date-time with `min_date` / `max_date` (e.g. `0` for now).
- Set the fast year-selector range with `year_start` / `year_end`.
- Allow editors to clear a value back to empty with `allow_blank`.
- Attach the picker to Views exposed `date`/`search_api_date` filters automatically via `single_datetime_exposed`.
- Provide a single-input widget for `daterange` (start + end) fields via `single_datetime_range`.
- Add the picker to a custom Form API form using the `single_date_time` element type.
- Attach the picker to a plain `textfield` using `AttributeHelper::defaultWidget()` and the `single_datetime/datetimepicker` library.
- Standardise date entry UX across many content types by choosing this widget per field.
- Give a friendlier, mobile-consistent calendar than the browser's native date control.
- Set an initial display date for empty inputs with `start_date`.
- Present a purchase-date or event-date field as one compact control.
- Combine minute granularity + allowed hours to build an appointment-slot picker.
- Configure per form mode (e.g. picker on the default form, plain widget on a custom form).
- Deploy the widget choice and its settings through exported `entity_form_display` config.
