<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Datetime Flatpickr that adds a Better Exposed Filters (BEF) widget, `bef_flatpickr`, so a Views exposed **date** filter can be rendered as a flatpickr calendar picker.

---

`datetime_flatpickr_bef` provides a single BEF filter-widget plugin, `bef_flatpickr` (label "Date Picker
with Flatpickr"), implemented by `FlatpickrDateBef extends FilterWidgetBase` and reusing the parent
module's `DateTimeFlatPickrWidgetTrait`. Its `isApplicable()` limits it to Views **Date** filters (a
`views…filter\Date` handler, or one with a `date_handler`) that are not grouped. When selected for an
exposed date filter, `exposedFormAlter()` swaps the exposed element's `#type` to the parent module's
`datetime_flatpickr` render element (handling single-value and min/max double-date filters) and applies
the configured flatpickr options. The plugin's own "Flatpickr settings" sub-form (built from the shared
trait, default `dateFormat` `Y-m-d`) is stored inside the view's BEF configuration. It has no config
object, permissions, or routes of its own. Requires `better_exposed_filters`, `datetime`, and
`datetime_flatpickr`. You enable it per view by editing the view's exposed form (set format to *Better
Exposed Filters*, then choose *Date Picker with Flatpickr* for the date filter).

---

- Render a Views exposed "created/updated date" filter as a flatpickr calendar.
- Turn an exposed date-range (min/max) filter into two flatpickr inputs.
- Give site visitors a friendly date picker on a search/listing page's exposed filters.
- Constrain the selectable dates in an exposed filter with min/max date settings.
- Disable weekends or specific dates in an exposed date filter.
- Use a consistent flatpickr date UX on both content forms and Views exposed filters.
- Provide a localized calendar on an exposed date filter.
- Configure the date format shown in an exposed filter via the BEF "Flatpickr settings".
- Replace a plain HTML date input in an exposed filter with a nicer calendar.
- Add a time picker to an exposed datetime filter.
- Position the calendar above/below the exposed filter input.
- Show week numbers in an exposed filter's calendar.
- Enable 24-hour time on an exposed datetime filter.
- Apply the picker only to date filters (the widget auto-hides for non-date filters).
- Build a filtered event calendar page with flatpickr-driven exposed date filters.
- Let editors pick "Date Picker with Flatpickr" as the widget for a date filter in the Views UI.
- Keep exposed-filter date entry consistent with the field-widget date entry across the site.
- Offer inline calendars in an exposed filter form.
- Reuse the same flatpickr settings trait inside Better Exposed Filters.
