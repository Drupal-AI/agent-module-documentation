<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BEF DateRange Picker adds a visual calendar date-range picker widget (Bootstrap Daterangepicker) to Views "is between" date exposed filters via Better Exposed Filters.

---

BEF DateRange Picker registers a single Better Exposed Filters widget plugin, `BefDateRangeWidget` (plugin id `bef_daterange_picker`), that becomes selectable in a view's BEF settings for any date exposed filter using the "Is between" operator (it is applicable to Views `Date` filters, or filters exposing `date_handler`, that are not grouped). At render time the widget attaches the `bef_daterange_picker/daterangepicker` library (Moment.js + Bootstrap Daterangepicker + the module's JS/CSS) and replaces the two plain `min`/`max` date text inputs with one read-only display input driven by a calendar range picker. Admins configure per-filter default min/max dates (PHP relative-date strings like `first day of this month`), a newline-delimited list of quick-select presets in `Label|start|end` format, and an "always show calendars" toggle. Preset start/end strings are parsed server-side with `\DateTime` and passed as ISO dates in `drupalSettings`; "this week"/"last week" presets are computed dynamically from Drupal's `system.date` first-day-of-week setting. The module also works around a core Views bug where clicking Reset on numeric/date filters raises "Undefined array key" errors: `hook_form_views_exposed_form_alter()` replaces the Reset submit button with a plain link back to the current path (no query string) whenever the form carries the widget's `#has_bef_daterange_picker` marker. On the JS side the picker keeps the hidden `min`/`max` inputs in sync and adds one day to the end date to make Drupal's "between" filter inclusive of the last selected day. There are no routes, permissions, services, entities, or config schema of its own — configuration lives inside the host view's BEF settings.

---

- Add a visual calendar range picker to a Views date exposed filter instead of two bare text inputs.
- Turn a "content is between two dates" filter into a friendly single-click range selector.
- Provide quick-select presets (Today, Yesterday, This Week, Last Week, This Month, Last Month) on an exposed date filter.
- Define custom presets like `Last 7 Days|-6 days|today` or `Q1 2026|2026-01-01|2026-03-31`.
- Set a default visible range (e.g. current month) using PHP relative-date strings for min and max.
- Respect the site's first-day-of-week setting so "This Week"/"Last Week" align to Sunday-start (Israeli) or Monday-start (international) calendars.
- Ensure content created on the last day of a selected range is included by adding a day to the end bound for the "between" operator.
- Filter a content listing view by created/changed/published date range with a calendar UI.
- Build an events or bookings view filtered by a date-range picker.
- Give editors a dashboard view where they pick reporting periods (this month, last month, custom).
- Keep full Views AJAX compatibility so the listing refreshes without a page reload when a range is applied.
- Optionally always show the calendars, or only reveal them when "Custom Range" is chosen.
- Avoid the core "Undefined array key 'min'" fatal/warning when users click Reset on a date filter.
- Give users a clean Reset that clears all exposed-filter query parameters via a link.
- Offer a localized display format (e.g. "Dec 1, 2025 - Dec 31, 2025") while storing ISO `YYYY-MM-DD` for Drupal.
- Style date filtering consistently across multiple views by reusing one BEF widget.
- Support reporting views that need both a sensible default period and ad-hoc custom ranges.
- Replace a clunky pair of date fields on a public-facing search page with a single modern picker.
- Provide period filters for analytics/log listing views.
- Let site builders configure everything through the Views UI with no code.
