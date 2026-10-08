# Datetime Range Popup — widget

## Enabling

On an entity bundle with a **Date-range (`daterange`)** field, go to *Manage form display* and set
that field's widget to **DateTime Range Popup** (`datetime_range_popup_widget`). No global config,
permissions, routes, or Drush — everything is per-widget-instance and stored in the form display's
`content.<field>.settings`.

## Settings (`settingsForm` / `defaultSettings`)

| Setting | Element | Options / default | Effect |
|---|---|---|---|
| `hour_format` | select (required) | `12h`, `24h` — default `24h` | Time display format. |
| `allow_times` | select (required) | `5`,`10`,`15`,`30`,`60` — default `15` | Minute increment in the picker. |
| `disable_days` | checkboxes | `1`=Mon … `7`=Sun — default none | Weekdays that cannot be selected. |
| `week_start` | radios | `1`=Mon … `7`=Sun — default `7` | Day the calendar week starts on. |
| `exclude_date` | textarea | default empty | Specific dates to disable, `YYYY-MM-DD`, one per line / comma-separated. |

`settingsSummary()` lists the current hour format, granularity, disabled days, week start, and
excluded dates on the Manage form display row.

## Form elements & JS wiring

The widget renders two custom form elements:
- `date_time_range_start` — `\Drupal\datetime_range_popup\Element\DatetimeRangePopup`
- `date_time_range_end` — `\Drupal\datetime_range_popup\Element\DatetimeRangePopupEnd`

Each element's `processDatetimeRangePopup()` reads the site's `system.date` `first_day`, converts the
settings into HTML `data-*` attributes on the input, and attaches the
`datetime_range_popup/datetime_range_popup` asset library:

`data-hour-format`, `data-allow-times` (int), `data-first-day`, `data-disable-days` (JSON array;
Sunday `7` is mapped to `1` for the JS lib), `data-week-start`, `data-exclude-date` (array), plus
`data-date-time-range-start` / `-end` carrying the field's datetime type. The pickers are driven by
`js/datetime_range_popup.js` and `js/drupal.datetime_range_popup.js`.

## Value handling

- `formElement()` sets timezone to storage timezone for date-only fields and applies the correct
  storage format (`DATE_STORAGE_FORMAT` vs `DATETIME_STORAGE_FORMAT`).
- `validateStartEnd()` (an `#element_validate` callback) errors if start > end.
- `massageFormValues()` converts each submitted start/end back to the storage timezone/format on save.

## External asset note

The `datetime_range_popup` library (`datetime_range_popup.libraries.yml`) loads several resources from
**external CDNs**: `maxcdn.bootstrapcdn.com` (Bootstrap 3.3.2 JS), `cdnjs.cloudflare.com`
(bootstrap-material-design ripples/material JS+CSS), `momentjs.com` (moment-with-locales), and
`fonts.googleapis.com` (Roboto + Material Icons). The widget therefore depends on outbound requests to
those third-party hosts and is subject to their availability/versioning; self-hosting these assets (or
overriding the library) is advisable for privacy/reliability. Bundled local assets: `css/datetime_range_popup.css`
plus the two JS files. `hook_help` renders the module README (via the Markdown filter when available).
