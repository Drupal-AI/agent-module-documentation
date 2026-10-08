<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Date Filter (project "Views Date Filter") transparently replaces the two core Views date filter handlers — the timestamp filter (`date`) and the Date/time field filter (`datetime`) — with improved versions that render real HTML5 date (and optionally time) pickers on exposed filters.

---

The module is plug-and-play: it has no settings form, no `configure` route, no permissions, no Drush commands and no new plugin IDs. Its whole job is one `hook_views_plugins_filter_alter()` implementation in `date_filter.module` that swaps the `class` of the existing `date` and `datetime` Views filter plugin definitions to `Drupal\date_filter\Plugin\views\filter\DateTimestamp` and `Drupal\date_filter\Plugin\views\filter\DateTime`. Both extend a shared `DateBase` (itself a `NumericFilter` subclass), so timestamp and Date/time fields finally behave identically. In the Views UI, core's "Value type: date / offset" radios are replaced by a **Filter type: Date / Date and time** radio set stored in the filter's top-level `type` option (`date` | `datetime`); on a date-only Date/time field the radios are disabled and forced to `date`. Exposed filters no longer render plain text boxes: `valueForm()` builds `#type => 'date'` elements (`<input type="date">`, plus an `<input type="time" step="1">` when the filter type is `datetime`), pre-populating them by parsing whatever the admin default was — including relative offsets such as `-1 month` — into real dates. The `between` / `not between` operators get **from** / **to** labels instead of core's min/max, the useless `regular_expression` operator is removed, and the exposed placeholder settings are dropped. Query building is overridden too: date-only filtering pads the value to the whole day (`>=`/`>` → `00:00:00`, `<=`/`<` → `23:59:59`, `between` min → `00:00:00` and max → `23:59:59`), and `=` / `!=` on a date-only filter are rewritten into `between` / `not between` over that day. Timezone handling differs per handler: `DateTimestamp` always parses input in the site/user timezone and emits a UNIX timestamp, while `DateTime` parses date-only fields in the storage timezone (UTC) and datetime fields in the site timezone before converting to the field's storage format.

---

- Give site visitors a real calendar picker on an exposed "Authored on" filter instead of a free-text date box.
- Add an exposed from/to date range filter to a news listing view without installing Better Exposed Filters.
- Filter an events view on a Date/time field with both a date and a time-of-day input.
- Replace the confusing core "min"/"max" labels on a `between` date filter with "from"/"to".
- Let editors filter an admin content view by "changed" date using a datepicker.
- Build a "published this month" view whose exposed default is an offset (`-1 month`) yet still shows a concrete date in the picker.
- Filter a date-only Date/time field so that `=` matches the entire day rather than midnight exactly.
- Make `>=` on a date-only filter include everything from 00:00:00 of the chosen day.
- Make `<=` on a date-only filter include everything up to 23:59:59 of the chosen day.
- Stop exposing the meaningless "An offset from the current time" radio to end users.
- Remove the `regular_expression` operator from a date filter's operator list.
- Give a timestamp field (`created`, `changed`, `login`, `access`) the same filtering UX as a Date/time field.
- Filter a Views block of upcoming events by a date range chosen by the visitor.
- Add a booking/report view with a start and end datetime picker for a date range report.
- Filter media or taxonomy views on their `created` timestamp with a picker.
- Provide date-range filtering in a Views REST/data export display driven by query parameters.
- Keep filter values timezone-correct for date-only fields, which are stored without a timezone.
- Standardise date filtering UX across every view on a site by simply enabling one module.
- Ship the date-filter configuration in exported Views config (`type: datetime` on the filter).
- Migrate a view from a text date filter to a picker-based one without changing the plugin ID.
- Subclass `DateBase` in a custom module to add site-specific date filter behaviour.
- Combine with a Views exposed form block so visitors get date pickers in the sidebar.
- Filter a calendar-style listing to a single chosen day using the `=` operator.
- Provide "last 7 days" style admin views whose exposed defaults render as real dates.
- Audit views config for filters that still use core's `value.type: offset` instead of the module's top-level `type`.
