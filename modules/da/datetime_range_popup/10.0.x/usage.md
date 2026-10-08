Datetime Range Popup adds a single field widget for core Date-range (`daterange`) fields that renders start/end inputs with a Materialize-style popup datetime picker, configurable with hour format, minute granularity, disabled weekdays, week start, and specific excluded dates.

---

The module provides one field widget, `datetime_range_popup_widget` (`DatetimeRangePopupWidget`, extending core `DateRangeWidgetBase`), selectable on an entity's *Manage form display* for `daterange` fields. It builds two custom form elements — `date_time_range_start` (`DatetimeRangePopup`) and `date_time_range_end` (`DatetimeRangePopupEnd`) — which attach the `datetime_range_popup` asset library and expose the widget settings to JavaScript as `data-*` attributes (`data-hour-format`, `data-allow-times`, `data-first-day`, `data-disable-days`, `data-week-start`, `data-exclude-date`, and the field's date/time type). The picker itself is driven by `js/datetime_range_popup.js` + `js/drupal.datetime_range_popup.js`. Per-widget settings (with defaults) are `hour_format` (`24h`), `allow_times` minute granularity (`15`), `disable_days` (checkboxes Mon–Sun), `week_start` (`7`), and `exclude_date` (newline/comma-separated `YYYY-MM-DD` list); an element validator enforces start ≤ end, and `massageFormValues()` converts picked values back to storage timezone/format. There are no permissions, routes, config schema, or Drush commands. Note the asset library loads several third-party resources from external CDNs (Bootstrap, cloudflare bootstrap-material-design, momentjs.com, Google Fonts/Material Icons), so the widget depends on outbound requests to those hosts.

---

- Provide a popup calendar+time picker for a Date-range field's start and end on content forms.
- Let editors pick a start/end datetime range without typing raw ISO strings.
- Enforce that the end date is not before the start date (built-in validation).
- Choose 12-hour or 24-hour time display in the picker.
- Set minute granularity for time selection (5, 10, 15, 30, or 60 minutes).
- Disable specific weekdays (e.g. weekends) from being selectable.
- Define which day the calendar week starts on.
- Block specific calendar dates (holidays/blackout days) via an excluded-dates list.
- Use the widget on date-only `daterange` fields (no time component).
- Use the widget on datetime `daterange` fields (date + time).
- Apply a consistent Materialize-styled date range picker across content types.
- Configure the widget per form display so different bundles can differ.
- Show the widget's current settings in the Manage form display summary.
- Store values correctly by converting the picked local value to the storage timezone on save.
- Add a booking/reservation start–end selector to an entity form.
- Add an event start–end datetime range picker.
- Provide an availability window picker with weekends disabled.
- Localize the first day of week to match site/regional settings (`system.date` first_day).
- Restrict a promotion's active range with excluded blackout dates.
- Replace the default HTML5 daterange inputs with a friendlier popup UI.
