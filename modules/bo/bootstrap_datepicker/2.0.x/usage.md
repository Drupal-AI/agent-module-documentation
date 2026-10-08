<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Datepicker provides a Drupal field widget (`bootstrap_date_widget`) and a matching `bootstrap_datepicker` form element that render core Date/time fields with the jQuery [uxsolutions/bootstrap-datepicker](https://github.com/uxsolutions/bootstrap-datepicker) calendar popup, exposing that library's many options (date format, language, start view, disabled days, start/end date, etc.) as widget settings.

---

The module registers one field widget plugin, `bootstrap_date_widget` (label "Bootstrap Datepicker"), for `datetime` fields; it extends core's `DateTimeWidgetBase`, so it participates in normal date storage/timezone handling and only changes the editing UI. It also defines a render element `bootstrap_datepicker` (`BootstrapDate`) whose process callback turns the element into a text input carrying `data-provide="datepicker"` plus `data-date-*` attributes for every setting that differs from the library defaults, and attaches the `bootstrap_datepicker/datepicker` JS library (plus a per-language locale library). The widget's `settingsForm()` surfaces roughly forty options from the JS plugin — `format`, `language`, `week_start`, `start_view`, `min_view_mode`/`max_view_mode`, `today_btn`, `today_highlight`, `autoclose`, `clear_btn`, `calendar_weeks`, `orientation`, `start_date`/`end_date` (as absolute dates or timedeltas), `days_of_week_disabled`/`highlighted`, `dates_disabled`, `rtl`, `z_index_offset`, and more — stored as ordinary field-widget settings on the entity form display (`content.<field>.settings`). The actual popup requires the third-party JS/CSS library to be installed at `/libraries/bootstrap-datepicker` (declared in `bootstrap_datepicker.libraries.yml`); without it the field still saves but the calendar UI will not appear. There is no admin settings page, permission, Drush command, or config schema of its own — all configuration is per-field on *Manage form display*.

---

- Give a Date/time field a Bootstrap-styled calendar popup instead of the default HTML5 date input.
- Configure the visible date format (e.g. `dd/mm/yyyy`) per field.
- Localize the calendar to a specific language via the widget's language tag setting.
- Set the first day of the week (e.g. Monday) for the picker.
- Auto-close the calendar as soon as a date is selected (`autoclose`).
- Add a "Clear" button to empty the field from the picker.
- Restrict selectable dates with a start date and/or end date (absolute or relative timedelta).
- Disable specific weekdays (e.g. weekends) in the calendar.
- Highlight specific weekdays or highlight "today".
- Disable an explicit list of dates (holidays) via the "dates disabled" setting.
- Choose the initial view (days/months/years/decades/centuries) with start view.
- Constrain the picker to month- or year-only selection via min/max view mode.
- Show ISO calendar week numbers next to each row.
- Control popup orientation (top/bottom/left/right/auto) relative to the input.
- Set a custom title above the datepicker popup.
- Provide a "Today" button that moves the view to the current date.
- Support RTL languages by toggling the picker's direction.
- Apply a datepicker to date-only, date-and-time, or all-day datetime fields.
- Keep native Drupal date storage/timezone behavior while swapping only the input UI.
- Set the popup's z-index offset to sit above other layered UI.
- Enable the picker even on read-only inputs.
- Standardize date entry UX across content types by selecting this widget on each date field.
- Assume a nearby century for two-digit year entry (e.g. "5/1/15" → 2015).
- Show/hide the weekday header row in the calendar.
