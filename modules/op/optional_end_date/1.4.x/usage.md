Optional end date makes the end date of a core Date range (daterange) field optional, so content such as events can be saved with only a start date and no end date.

---

Drupal core's Date range field (`daterange`, from the `datetime_range` module) always requires both a start and an end value. Optional end date changes this per field: it uses `hook_field_info_alter()` to swap the `daterange` field type class for `OptionalEndDateDateRangeItem`, which adds an **"Optional end date"** checkbox to the field's Storage settings form. When that box is checked, the field's `end_value` property is marked not required, the item's `isEmpty()` treats a value with only a start date as non-empty, and the `NotNull` validation constraint on `end_value` is dropped. It also swaps the matching widgets (`daterange_default`, `daterange_datelist`) so the End date form element is no longer required and is labelled "End date (optional)", and swaps the three core formatters (`daterange_default`, `daterange_plain`, `daterange_custom`) so they render just the start date when the end date is empty. On install, a `hook_install()` alters existing daterange database columns to allow NULL in the `*_end_value` column. The module has no admin settings page — configuration happens entirely on each daterange field's Storage settings. It requires only core `datetime_range` and mimics the optional-end-date behavior later added to Drupal core.

---

- Let editors create an event that has a start date but no known end date.
- Make the end date optional on an existing daterange field via its Storage settings.
- Allow open-ended date ranges (e.g. "available from" with no end).
- Model a subscription or membership that started on a date and has no end yet.
- Record a "published since" date range where the end is intentionally blank.
- Save a daterange value with only the start filled in without a validation error.
- Show only the start date in field output when the end date is empty.
- Keep the "End date" widget field but no longer force editors to fill it in.
- Label the end date form element clearly as "End date (optional)".
- Support job postings or offers with an open closing date.
- Represent an ongoing exhibition or campaign with no scheduled end.
- Migrate legacy content that has start-only dates into a daterange field.
- Allow a single-instant daterange (start == end collapses to one date in output).
- Add the "Optional end date" checkbox to the daterange field type storage settings.
- Drop the required constraint on `end_value` only for the fields you opt in.
- Use the default daterange widget while permitting an empty end date.
- Use the datelist (select boxes) daterange widget while permitting an empty end date.
- Store NULL in the `_end_value` column for existing daterange fields after install.
- Reproduce Drupal 8.9+ core optional-end-date behavior on older sites.
- Uninstall cleanly later and move to core's implementation once adopted.
- Keep validation strict on daterange fields that should still require both dates (leave the box unchecked).
- Combine with any daterange field on nodes, taxonomy terms, users, or custom entities.
- Render open-ended ranges correctly with the plain and custom date formatters.
- Build a "valid from / valid to" field where "valid to" may be empty.
