AP Style Date Formats renders date, timestamp, and date-range fields following Associated Press style guidelines (abbreviated months like "Sept.", no ordinal suffixes, "noon"/"midnight", relative "today", TDP time-before-date ordering), via two field formatters, a reusable service, and a Twig filter.

---

The module adds two field formatters: **`timestamp_ap_style`** ("AP Style") for `datetime`, `timestamp`, `created`, `changed`, and `published_at` fields, and **`daterange_ap_style`** ("AP Style") for `daterange` and `smartdate` fields. Both share a large set of boolean options — always display year, use/capitalize "Today", display day of week, display time, hide date, time-before-date, noon/midnight handling, "All Day", month-only — plus a date-range `separator` (`to` / `endash` / `hyphen`) and an optional `timezone` override. Defaults for every option are set globally in the `date_ap_style.settings` config object (admin form at `/admin/config/regional/date-ap-style`, permission `administer ap style settings`), and each formatter instance can override them per view display. The formatting logic lives in the **`date_ap_style.formatter`** service (`ApStyleDateFormatter`) with two public methods, `formatTimestamp(int $timestamp, array $options, $timezone, $langcode, $fieldtype)` and `formatRange(array $timestamps, ...)`, which apply the AP month rules (`F` for March–July, `Sept.` for September, `M.` otherwise), year suppression for the current year, and lowercase `a.m.`/`p.m.` meridians. A Twig filter **`ap_style`** exposes the timestamp formatter in templates (`{{ my_timestamp|ap_style }}`, with an optional options array). The module has no dependencies (Smart Date is an optional dev suggestion) and ships config schema for the settings object and both formatter setting shapes.

---

- Display an article's publish date as "Sept. 4, 2025" instead of "September 4, 2025".
- Format a `created`/`changed` timestamp field in AP style on a node view display.
- Render a `daterange` event field as "Sept. 4 to 6" with a configurable separator.
- Format a Smart Date (`smartdate`) field range in AP style, including "All Day" events.
- Show "today" (optionally capitalized) for dates that fall on the current day.
- Display the day of the week ("Thursday") for dates within the current week.
- Set a site-wide default AP style configuration once at `/admin/config/regional/date-ap-style`.
- Override the global AP style options per field formatter on an individual view display.
- Always show the year even for current-year dates by enabling `always_display_year`.
- Show time before date (AP "TDP" ordering): "3 p.m. Thursday" via `time_before_date`.
- Render "noon" and "midnight" instead of "12 p.m."/"12 a.m." with `display_noon_and_midnight`.
- Hide the date and show only the AP-style time with `hide_date`.
- Display only the month (and year) with `month_only` for coarse date fields.
- Apply a fixed timezone override to a date formatter regardless of the site/user timezone.
- Choose an en dash, hyphen, or the word "to" as the range separator.
- Format a timestamp inside a Twig template with the `{{ timestamp|ap_style }}` filter.
- Pass custom options to the Twig filter: `{{ timestamp|ap_style({display_time: true}) }}`.
- Call `ApStyleDateFormatter::formatTimestamp()` from custom PHP to reuse the AP formatting.
- Call `ApStyleDateFormatter::formatRange()` to format a start/end pair in AP style.
- Standardize date display across a news/editorial site to match its style guide.
- Present event listings with AP-compliant date ranges spanning months or years.
- Combine "display time" with "use All Day" so midnight-to-midnight ranges read "All Day".
- Keep current-year event dates compact (no year) while older items show the year automatically.
- Provide editors an AP-styled date output without writing any custom formatting code.
