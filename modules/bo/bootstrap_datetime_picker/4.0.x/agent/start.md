<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap DateTime Picker — agent index

Renders core Date/time & Date-range fields (and a Webform element) with the Tempus Dominus / Bootstrap
datetimepicker JS calendar. Global settings at `/admin/config/content/bootstrap_datetime_picker`; per-widget
options on Manage form display. Depends on core `datetime` + the Tempus Dominus library in `/libraries`.

- **Global settings form, config keys, library/CDN, and per-widget settings** →
  [configure/settings.md](configure/settings.md)
- **The two field widgets, the render element, and the Webform element plugin** →
  [plugins/widgets.md](plugins/widgets.md)

Key facts:
- Config object `bootstrap_datetime_picker.settings` (global icons/library/display toggles).
- Settings form route `bootstrap_datetime_picker.settings`, permission **`administer site configuration`**.
- Widgets: `BootstrapDateTimeWidget` (datetime), `BootstrapDateRangeWidget` (daterange). Render element
  `bootstrap_datetime_picker` (theme `input__bootstrap_datetime_picker`). Webform element
  `Plugin/WebformElement/BootstrapDateTime`.
- Library `datetimepicker` (local) / `datetimepicker-cdn`; requires `/libraries/tempus-dominus`
  (checked by `hook_requirements`).
