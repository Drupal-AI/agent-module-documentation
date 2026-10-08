<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Single DateTimePicker Range is a submodule of single_datetime that adds a `single_date_time_range_widget` field widget for core **Datetime Range** (`daterange`) fields, rendering both the start and end inputs with the xdan jQuery datetimepicker.

---

The submodule ships one field widget plugin, `single_date_time_range_widget` (label "Single Date Time Picker", `field_types = {daterange}`), in `Drupal\single_datetime_range\Plugin\Field\FieldWidget\SingleDateTimeRangeWidget`. It extends the parent module's `SingleDateTimeBase`, so it inherits the full set of per-widget settings (`hour_format`, `allow_seconds`, `allow_times`, `allowed_hours`, `disable_days`, `exclude_date`, `inline`, `mask`, `datetimepicker_theme`, `start_date`, `min_date`, `max_date`, `year_start`, `year_end`, `allow_blank`) and applies them identically to **both** the `value` (start) and `end_value` (end) `single_date_time` render elements. The widget wraps the two inputs in a fieldset, replaces core's default `validateStartEnd` with its own `validateSingleDateTime` callback (start date must not be after end date — because values arrive as strings, not `DrupalDateTime` objects), and its `massageFormValues()` converts the start/end strings back to the storage timezone/format, honouring the field's `datetime_type` (date, all-day, or datetime). Its info.yml only declares a dependency on `datetime_range`, but the widget class extends `single_datetime`'s base class, so the parent **single_datetime module must also be enabled** and its xdan JS library present at `/libraries/jquery-datetimepicker`. There is no configure route, settings form, permission, service, or config schema of its own.

---

- Give a Datetime Range field (e.g. an event's start/end) a single-input calendar+time picker on both ends instead of core's separate date and time boxes.
- Present a booking window (check-in / check-out) with the xdan datetimepicker on start and end.
- Constrain a range field's time entry to 15- or 30-minute granularity via the inherited `allow_times` setting.
- Show a daterange field's picker in 12-hour (AM/PM) format by setting `hour_format` to `12h`.
- Disable weekends on both start and end inputs of a booking range with `disable_days`.
- Block specific holiday dates on a range field via `exclude_date`.
- Enforce that the end of a period is never before its start using the widget's built-in validation.
- Apply a minimum/maximum selectable date to an availability range with `min_date` / `max_date`.
- Use the dark picker theme on a range field's edit form via `datetimepicker_theme`.
- Render the range picker inline (always open) with the `inline` setting.
- Configure an all-day date range (no time inputs) and still get the calendar picker on both dates.
- Standardise range-field editing UX across content types by selecting this widget on each Manage form display.
- Swap an existing `daterange_default` widget to `single_date_time_range_widget` to modernise the range UI without changing storage.
- Limit selectable years on a historical date-range field with `year_start` / `year_end`.
- Allow clearing a previously set range with `allow_blank` so mobile users can unset a date.
- Provide a scheduling entity (campaign, promotion, membership period) with a friendly start–end picker.
- Combine with the parent single_datetime datetime/timestamp widgets so every date field on a form uses the same picker.
- Restrict allowed hours (e.g. business hours 8–17) on both range inputs via `allowed_hours`.
- Use a masked input (`__.__.____`) on both range inputs for keyboard entry.
- Set an initial display date for the picker when the range is empty via `start_date`.
