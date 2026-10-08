<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap DateTime Picker renders core Date/time and Date-range fields (and a Webform element) with the Tempus Dominus (Bootstrap datetimepicker) JavaScript calendar, with a global settings page for icons/library source and per-widget options like formats, min/max dates, disabled days/dates and time granularity.

---

The module depends on core `datetime` and the third-party **Tempus Dominus** library
(`/libraries/tempus-dominus`, or a CDN). It provides two field widgets —
`BootstrapDateTimeWidget` (Date/time) and `BootstrapDateRangeWidget` (Date-range) — a reusable render
element (`Element\BootstrapDateTime`, theme hook `input__bootstrap_datetime_picker`), and a Webform
element plugin (`Plugin/WebformElement/BootstrapDateTime`). A global settings form at
`/admin/config/content/bootstrap_datetime_picker` (route `bootstrap_datetime_picker.settings`, permission
**`administer site configuration`**) stores site-wide config `bootstrap_datetime_picker.settings`:
icon set (`icon_type` fontawesome/bootstrap-icons, with `use_cdn` for the icon CSS and
`use_tempus_dominas_cdn` for the picker library), the individual `display_icons_*` glyph classes, and the
picker's display/component toggles (`display_sideBySide`, `display_viewMode`, `display_components_*`,
`display_inline`, `display_theme`, `hourCycle`, `language`). Per-widget settings (chosen on Manage form
display) include `date_date_format`, `date_date_min`/`date_date_max`, `disabled_hours`, `disable_days`
(weekdays), `exclude_date` (specific dates), plus Bootstrap layout classes (`wrapper_class`,
`column_size_class`). A `hook_requirements` check reports whether the Tempus Dominus library is present.
Language locale files are loaded from `/libraries/tempus-dominus/dist/locales/*`.

---

- Replace the default HTML5 date input on a Date/time field with a Bootstrap calendar widget.
- Add a combined date-and-time picker to a content type field.
- Use a Bootstrap picker on a Date-range field for start/end selection.
- Add the picker to a Webform via the Bootstrap DateTime webform element.
- Use the render element in a custom form to get a Bootstrap datetime input.
- Choose Font Awesome or Bootstrap Icons for the picker's calendar/clock glyphs.
- Serve the Tempus Dominus library and icons from a CDN instead of a local copy.
- Self-host the Tempus Dominus library under `/libraries` for offline/air-gapped sites.
- Constrain selectable dates with a per-widget minimum and maximum date.
- Disable specific weekdays (e.g. weekends) on a booking-style field.
- Disable specific calendar dates (holidays/blackout days).
- Disable specific hours of the day for time selection.
- Set the minute granularity for the time picker.
- Show the picker inline (always visible) rather than on focus.
- Show date and time side by side in the picker.
- Restrict the picker to date-only or show/hide seconds via component toggles.
- Set a custom date display format per widget.
- Localise the calendar to a chosen language.
- Force a light/dark/auto picker theme.
- Add Bootstrap grid/layout classes around the widget for responsive forms.
