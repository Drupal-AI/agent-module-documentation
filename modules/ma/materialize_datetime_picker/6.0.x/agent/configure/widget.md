<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the widget and global defaults

## Per-field widget
On a content type's **Manage form display**, set a `datetime` field's widget to **Materialize DateTime Picker**. Widget settings (`defaultSettings`):
- `hour_format` — `12h` / `24h`
- `allow_times` — minutes granularity `5|10|15|30|60`
- `disable_days` — checkboxes for weekdays to disable
- `week_start` — start-of-week day
- `exclude_date` — comma-separated `YYYY-MM-DD` dates to disable

The widget passes these to the `materialize_date_time` element (`#hour_format`, `#allow_times`, `#disable_days`, `#week_start`, `#exclude_date`). `massageFormValues()` builds a `DrupalDateTime`, applies the storage timezone, and formats for `DATE_STORAGE_FORMAT` (date-only) or `DATETIME_STORAGE_FORMAT`.

## Site-wide defaults
Route `materialize_datetime_picker.materialize_datetime_picker_config` → `/admin/config/materialize/datetime_picker_config` (perm `access administration pages`). Stored in `materialize_datetime_picker.site_config_datetime:materialize_datetime_data`:
- `date_type_format` (date / datetime), `fields_date_only`, `fields_datetime_only` (comma-separated field-ID overrides), `hour_format`, `allow_times`, `disable_days`, `week_start`, `exclude_date`.

## Asset note
The library loads Bootstrap, material-design, moment.js and Google Fonts from external CDNs. Consider vendoring these locally for privacy, offline support, and supply-chain safety. A Bootstrap base theme auto-removes the duplicate Bootstrap 3 JS.
