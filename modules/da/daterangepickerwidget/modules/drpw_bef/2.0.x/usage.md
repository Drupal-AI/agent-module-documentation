Adds a Better Exposed Filters widget that puts the jQuery UI date range picker on a standard core Date views filter using the "between"/"not between" operator.

---

`drpw_bef` is the Better Exposed Filters sub-module of the jQuery UI DateRangePicker Widget project. It registers a `bef_daterangepicker` BEF filter widget (`DateRangePickerFilter` extending `FilterWidgetBase`) that is offered whenever an exposed views filter is a core Date filter (or has a `date_handler`), is not grouped, and uses the `between` or `not between` operator. When selected, it hides the filter's two min/max date inputs and renders a single jQuery UI date range picker (reusing the base module's shared options form and trait). Client-side, `js/daterangepicker.js` copies the chosen range into the hidden fields as `min = start 00:00:00` and `max = end 23:59:59`, so the standard Views "between" query runs unchanged. Requires the base `daterangepickerwidget` module and Better Exposed Filters `^7.0`.

---

- Replace the default two-field "between" date filter in an exposed Views form with a single popup range picker.
- Give site visitors a Google-Analytics-style calendar to select a date span for filtering listings.
- Apply the picker to any core Date exposed filter (content authored-on, custom date fields, etc.) using "between"/"not between".
- Configure the picker's appearance per filter: months shown, min/max date, first day of week, step months, year range, dropdowns.
- Localize the picker's prompt and button labels through the BEF configuration form.
- Feed a normalized `start 00:00:00` / `end 23:59:59` range into the standard Views between query automatically.
- Add custom preset ranges (Today, Last week, Last 3 months, etc.) to the exposed filter via `hook_form_views_exposed_form_alter()`.
- Build public "filter by date range" search UIs (events, articles, reports) without writing custom form code.
- Keep the raw min/max inputs hidden and visually replaced while preserving the underlying Views filter behavior.
- Reuse identical date-range-picker options across a field widget and a BEF-exposed filter for a consistent UI.
