Adds a `daterangepicker` field type (storing a JSON start/end range) with a picker widget, a configurable formatter, and Views filter/sort handlers for that range.

---

`drpw_field` is the field-type sub-module of the jQuery UI DateRangePicker Widget project. It defines the `daterangepicker` field type (`DateRangePickerItem`) whose single `value` column is a 255-char varchar holding a JSON string `{"start":"yy-mm-dd","end":"yy-mm-dd"}`. The default widget (`DateRangePickerDefaultWidget`) renders the base module's jQuery UI picker and exposes the full shared options form (initial text, button labels, date format, months, min/max, first day, step months, year range, dropdowns). The default formatter (`DateRangePickerDefaultFormatter`) decodes the JSON and prints two `<time>` elements with a configurable PHP date format and range separator. `hook_views_data_alter()` rewires every `daterangepicker` field column to a custom Views filter and sort handler; the filter offers subset/superset/intersect/not-intersect operators and the sort can order by start date, end date, or day interval — all computed in SQL with `JSON_EXTRACT`/`JSON_UNQUOTE` (and `DATEDIFF` for the interval). Requires the base `daterangepickerwidget` module.

---

- Add a single-field date **range** (start + end) to any content type, taxonomy term, user, or other fieldable entity.
- Capture booking/reservation windows, event durations, or availability periods in one field.
- Let editors pick the range in a Google-Analytics-style two-calendar popup.
- Configure the widget per form display: number of months, min/max date, first day of week, step months, year range.
- Show month and/or year dropdown selectors in the picker.
- Localize the picker's prompt and button text on the widget settings form.
- Enforce `step_months <= number_of_months` via the shared widget validator.
- Format the stored range on display with any PHP date format (e.g. `j M, Y`) and a custom separator.
- Render machine-readable `<time datetime="Y-m-d">` markup for the start and end dates.
- Set a default value range on the field via the field's default-value form.
- Filter a View by ranges that are a **subset** of a chosen range (fully contained).
- Filter by ranges that are a **superset** of a chosen range (fully containing it).
- Filter by ranges that **intersect** a chosen range (any overlap).
- Filter by ranges that **do not intersect** a chosen range.
- Expose that range filter to site visitors so they can search content by a date span.
- Sort a View by the range's **start date**.
- Sort a View by the range's **end date**.
- Sort a View by the range **interval** (number of days between start and end, via `DATEDIFF`).
- Build availability listings, event calendars, or reservation search pages driven by range overlap logic.
