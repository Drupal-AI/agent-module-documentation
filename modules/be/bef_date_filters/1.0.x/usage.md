<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BEF Date filters adds a single Better Exposed Filters widget, "Year and month for date range", that turns a Views date "Is between" exposed filter into a Year dropdown and a Month dropdown, computing the underlying date range for the visitor instead of making them type dates into text inputs.

---

Better Exposed Filters improves the presentation of Views exposed filters, but its stock widgets are oriented at lists and text, so a plain exposed date filter renders as text inputs into which a visitor must type a parseable date — a reliable source of empty result sets. This module registers one BEF filter-widget plugin, `bef_year_month_between`, that is offered only for date filter handlers that are not grouped. When chosen, it hides the native min/max date inputs and shows two selects instead: a Year (the current year through the ten prior years) and a Month (January–December). A small client-side behaviour maps the picked year and month to the hidden min/max fields — a chosen month becomes that calendar month, a year with no month becomes the whole year, and Views then processes the resulting range through its normal date filter. There is no settings page and no configuration object of its own; the widget is selected per filter in the Views UI, and BEF stores that choice in the display's exposed-form settings. It depends on `better_exposed_filters` (which brings Views) and runs on Drupal `^10 || ^11`. Because a range that resolves against "the current year" is time-dependent, a page cached for a long lifetime can show a stale idea of "now", so confirm the display's cache max-age where that matters.

---

- Filter a news archive by year and month with dropdowns.
- Turn a "content is between two dates" filter into year/month selects.
- Let visitors browse posts month by month.
- Filter a blog listing by publication year.
- Filter events by the month they occur.
- Stop visitors having to type dates in the right format.
- Reduce empty result sets caused by bad date input.
- Add a whole-year filter (pick a year, leave the month blank).
- Add a single-month filter (pick a year and a month).
- Improve mobile usability of a date filter (selects, not typing).
- Filter a document archive by period.
- Filter a report view by year.
- Give an exposed created/changed-date filter a friendlier control.
- Filter a photo gallery by month taken.
- Browse meeting minutes by year and month.
- Filter podcast episodes by release month.
- Provide an "archive by month" style navigation on a view.
- Combine the year/month widget with BEF's other exposed-filter widgets.
- Filter a datetime field ("Is between") without a date picker.
- Make a date-range filter accessible via labelled selects.
