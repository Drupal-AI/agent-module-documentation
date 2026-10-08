<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bootstrap Materialize DateTime Picker provides a Materialize-styled date/time picker as a Drupal field widget and custom form element for core datetime fields.
---
The module registers a field widget (`materialize_date_time_widget`, for `datetime` fields, extending `DateTimeWidgetBase`) and a custom render element (`materialize_date_time`) backed by JS that initializes the Materialize datetimepicker. Per-widget settings include hours format (12h/24h), minutes granularity (5–60), disabled weekdays, start-of-week, and a comma-separated list of specific disabled dates (`YYYY-MM-DD`); these are passed to the element via `#hour_format`, `#allow_times`, `#disable_days`, `#week_start`, `#exclude_date`. `massageFormValues()` converts the picked string to a `DrupalDateTime`, applies the storage timezone, and formats it for date-only or datetime storage. There is also a site-wide config form at `/admin/config/materialize/datetime_picker_config` (route gated by `access administration pages`) storing global defaults (date type, per-field-id overrides, hours format, granularity, disabled days/dates, start week) under `materialize_datetime_picker.site_config_datetime`.

Operationally the main consideration is asset delivery: the library `materialize_datetime_picker` loads several assets from external CDNs and third-party hosts (`maxcdn.bootstrapcdn.com`, `cdnjs.cloudflare.com`, `momentjs.com`, `fonts.googleapis.com`) as external JS/CSS. This creates a third-party/CDN dependency and privacy consideration (visitor requests to those hosts) and a supply-chain/availability risk if a CDN is unreachable or compromised; `hook_library_info_alter()` only removes the Bootstrap 3 JS when a Bootstrap base theme is active. There are no server-side mutating endpoints beyond the permissioned admin config form, no external data fetching by PHP, and no SQL. The `access administration pages` permission on the global config route is broad but the form only writes module configuration.
---
- Use the "Materialize DateTime Picker" widget on a datetime field ("Manage form display").
- Choose 12-hour or 24-hour time entry.
- Set minutes granularity (5/10/15/30/60) for the time picker.
- Disable specific weekdays (e.g. weekends) in the calendar.
- Define which day the week starts on.
- Disable specific calendar dates via a comma-separated `YYYY-MM-DD` list.
- Configure a date-only vs date-and-time picker per field.
- Set site-wide defaults at `/admin/config/materialize/datetime_picker_config`.
- Override date/datetime behavior for specific field IDs globally.
- Provide a consistent Material-design datetime UI across forms.
- Store values in the correct timezone via widget massaging.
- Apply the picker to event start/end date fields.
- Give content editors a friendlier calendar than the default widget.
- Reuse the `materialize_date_time` render element in custom forms.
- Auto-drop conflicting Bootstrap 3 JS when a Bootstrap base theme is active.
- Localize the picker via the bundled moment-with-locales asset.
- Restrict global configuration to users with admin-pages access.
- Match the datetime widget styling to a Materialize-themed site.
- Configure disabled dates for holidays/blackout days.