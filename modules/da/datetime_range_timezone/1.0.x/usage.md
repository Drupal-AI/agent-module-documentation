<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Datetime Range Timezone adds a `daterange_timezone` field type (with matching widget and formatters) that extends core's Datetime Range so each date range also stores the timezone the editor entered it in, and displays it back in that timezone.

---

The module builds on core `datetime_range`. Its `daterange_timezone` field type extends
`DateRangeItem` and adds a `timezone` varchar(255) column/property alongside the standard
start/end values. The `daterange_timezone` widget (which also works on plain `daterange`
fields) extends the core Date range widget and appends a **Timezone** select
(`TimeZoneFormHelper` region list); on save it re-interprets the entered start/end as being in
the chosen timezone before core converts them to UTC for storage, and on edit it renders the
stored values back in that timezone. Two formatters are provided: `daterange_timezone` (the
default) renders start–end via a Twig template (`datetime-range-timezone.html.twig`) with
settings `separator`, `format_type`, and `display_timezone`; and `daterange_timezone_single_date`
renders just one endpoint, with a `date_field` setting (`start_date` or `end_date`) plus
`format_type` and `display_timezone`. All date formatting uses the stored timezone so a range
reads correctly regardless of the viewer's or site's timezone. The module also integrates with
the Token module (`datetime_range_timezone.tokens.inc`): it adds `start_date`/`end_date` format
tokens for `daterange_timezone` fields and formats them using the field's stored timezone.
There is no settings form (`configure: null`), no permissions, and no Drush — it is purely
field plugins plus token support and a config schema for the field/formatter settings.

---

- Store the timezone an event's start/end datetime range was entered in, per value.
- Display an event's date range in its own timezone rather than the site or viewer timezone.
- Let editors pick a timezone from a region-grouped select when entering a date range.
- Show conference/webinar times consistently for a global audience (fixed to the event's zone).
- Render only the start (or only the end) of a range with the single-date formatter.
- Append the timezone label after a formatted date range (`display_timezone`).
- Hide the timezone label when it isn't needed (turn off `display_timezone`).
- Customize the separator between start and end dates in the default formatter.
- Choose the date format (`format_type`) used to render the range.
- Add timezone-aware event dates to any content type as a normal field.
- Reuse the widget on an existing core `daterange` field to capture a timezone.
- Output timezone-correct dates in tokens (e.g. emails) via the `start_date`/`end_date` format tokens.
- Show travel itineraries where departure/arrival are in different regions' local time.
- Present opening-hours or session windows in the venue's local timezone.
- Keep stored values in UTC while always displaying in the captured timezone.
- Provide an ISO `<time datetime>` value in the range template for machine readability.
- Format a single endpoint (e.g. only the start time) in listings or teasers.
- Support multilingual sites where dates must render in a specific event timezone.
- Avoid off-by-hours bugs from daylight-saving by pinning display to the entered timezone.
- Build calendars/schedules that respect each entry's own timezone.
- Migrate core daterange content to timezone-aware ranges by switching the field type/widget.
