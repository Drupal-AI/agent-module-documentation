The jQuery UI DateRangePicker Widget integrates the "comiseo" jQuery UI DateRangePicker (a Google-Analytics-style two-calendar range picker) into Drupal as a reusable form element, a field type, and a Better Exposed Filters plugin.

---

The project ships a base module plus two sub-modules. The base module (`daterangepickerwidget`) registers the `daterangepicker` render/form element and the shared `DateRangePickerTrait` that maps Drupal-side options to the underlying JavaScript API, and it declares the asset libraries (jQuery 1.8.3 sandboxed via `jQuery.noConflict(true)`, jQuery UI 1.9.2, Moment.js, and the comiseo daterangepicker plugin). The `drpw_field` sub-module adds a `daterangepicker` field type storing a JSON `{start,end}` string in a 255-char varchar column, with a widget, a formatter, and Views filter/sort handlers that reason over the range with `JSON_EXTRACT`. The `drpw_bef` sub-module exposes the picker as a Better Exposed Filters widget for standard core Date filters using the "between"/"not between" operators, driving the hidden min/max fields from the picker via JavaScript. All three share one options form (initial text, button labels, date format, number of months, min/max date, first day of week, step months, year range, month/year dropdowns, preset ranges) and store per-element configuration under `drupalSettings.daterangepicker`.

---

- Add a Google-Analytics-style date range picker as a custom form element (`'#type' => 'daterangepicker'`) in any custom form.
- Let editors pick a start and end date in a single popup with two side-by-side calendars.
- Store a date range on an entity via the `daterangepicker` field type (booking dates, event windows, availability periods).
- Display a stored range with a configurable PHP date format and a custom separator using the default formatter.
- Provide quick "preset ranges" (Today, This week, Last month, etc.) defined in PHP and evaluated client-side via Moment.js.
- Hide the preset-range column entirely with `#disable_preset_ranges` or an empty `#preset_ranges` array.
- Restrict selectable dates with `#min_date` / `#max_date` (e.g. disable past dates, allow booking up to one year ahead).
- Set a default pre-selected range with `#default_value => ['start' => ..., 'end' => ...]`.
- Show month and/or year dropdown selectors instead of plain-text headers.
- Configure the first day of the week (Sunday=0 … Saturday=6) to match locale conventions.
- Step through the calendars more than one month at a time with `#step_months`.
- Localize the picker's button and prompt text (Apply, Clear, Cancel, initial text).
- Expose a `daterangepicker` field as a Views filter with subset / superset / intersects / does-not-intersect range operators.
- Sort a Views listing by a range's start date, end date, or day-count interval.
- Attach the picker to a standard core Date field's exposed filter via Better Exposed Filters ("between"/"not between").
- Customize preset ranges on an exposed Views filter through `hook_form_views_exposed_form_alter()`.
- Reuse one shared options form across the field widget, the Views filter, and the BEF plugin for consistent configuration.
- Build availability or reservation search UIs where visitors filter content by an arbitrary date span.
- Filter reports or dashboards by a selected reporting window.
- Provide a compact single-input range control instead of two separate date fields on public-facing forms.
- Keep the picker's jQuery isolated from the site's own jQuery via `jQuery.noConflict(true)` to avoid version conflicts.
