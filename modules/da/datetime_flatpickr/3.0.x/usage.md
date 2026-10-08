<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Datetime Flatpickr provides field widgets that render Drupal core Date/time and Date-range fields with the lightweight [flatpickr](https://flatpickr.js.org/) JavaScript calendar/time picker, with a rich per-widget settings form (formats, min/max, disabled dates, time options, localization).

---

The module adds three field widgets — `datetime_flatpickr` (for `datetime` fields) and
`datetime_range_flatpickr` / `datetime_range_separate_inputs_flatpickr` (for `daterange` fields) — plus a
reusable `datetime_flatpickr` render/form element. You pick a widget on an entity's *Manage form display*
tab; there is no global settings page (`configure` is null) and no permissions. Each widget instance
stores a large settings array (schema `datetime_flatpickr_config`, e.g. `dateFormat`, `altInput`/`altFormat`,
`enableTime`, `enableSeconds`, `time_24hr`, `minDate`/`maxDate`, `minTime`/`maxTime`, `minuteIncrement`,
`position`, `weekNumbers`, `disabledWeekDays`, `disabledDates`, `inline`, `allowInput`, `mode`,
`use_system_format`/`system_date_format`) in the `entity_form_display` component. Those settings are
sanitized (`Html::escape` on string values), converted from PHP to flatpickr tokens where needed, and
passed to the browser as `drupalSettings.datetimeFlatPickr[<name>]`, where `js/datetime-flatpickr.js`
instantiates flatpickr. The flatpickr library and its locale files load from a CDN by default (the
`flatpickr` asset library points at cloudflare 4.6.11); `hook_library_info_alter` swaps to a locally
installed `libraries/flatpickr` copy when present, and the current interface language auto-loads the
matching flatpickr locale. `massageFormValues()` converts the picked value back to Drupal's storage
format/timezone on save. Two optional submodules extend the same settings trait to Better Exposed
Filters exposed date filters (`datetime_flatpickr_bef`) and Webform (`datetime_flatpickr_webform`).

---

- Replace the default HTML5 date input on a Date/time field with a flatpickr calendar widget.
- Add a combined date-and-time flatpickr picker by enabling the time picker on a datetime field.
- Use a flatpickr range picker on a Date-range (daterange) field with a single input.
- Use separate start/end flatpickr inputs for a Date-range field.
- Show the user a friendly display format (e.g. "F j, Y") while submitting a machine format via altInput.
- Constrain selectable dates with a minimum and/or maximum date on a booking field.
- Disable specific dates (holidays/blackout days) on an events date field.
- Disable specific weekdays (e.g. weekends) from being selectable.
- Restrict the selectable time window with min/max time on an appointment field.
- Set the minute step (e.g. 15-minute increments) for time selection.
- Present time in 24-hour mode without AM/PM.
- Enable seconds in the time picker where second precision matters.
- Render the calendar inline (always visible) instead of on focus.
- Position the calendar above or below the input explicitly.
- Show ISO week numbers in the calendar.
- Reuse a system (Regional settings) date format for the alternative display input.
- Allow or forbid direct keyboard entry into the date field.
- Localize the calendar automatically to the site's interface language.
- Serve the flatpickr assets from a self-hosted `libraries/flatpickr` copy instead of the CDN.
- Add a flatpickr date element to a Webform via the datetime_flatpickr_webform submodule.
- Turn a Views exposed date filter into a flatpickr picker via the datetime_flatpickr_bef submodule.
- Provide a consistent, lightweight date UX across content edit forms without jQuery UI.
- Use the `datetime_flatpickr` render element in a custom form to get a flatpickr-powered field.
- Configure a "jump to date" so the calendar opens on a specific month.
- Support single, multiple, or range selection modes via the `mode` setting.
