<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Age Field Formatter is a field formatter for core `datetime` fields that computes a person's (or anything's) age in whole years from the stored date to today and renders it — optionally alongside the formatted date and with a pluralized "years" suffix.

---

The module provides one `@FieldFormatter` plugin, `age_field_formatter` (`src/Plugin/Field/FieldFormatter/AgeFieldFormatter.php`), applicable to fields of type `datetime`. You select it on an entity's **Manage display** tab; there is no global settings page (`configure` is null) and no permissions. Age is calculated with `DrupalDateTime::diff()` on the `->y` (full-years) component between the field value and now. Three display modes are chosen via the `age_format` setting: `birthdate` renders `date (Age: NN)`, `birthdate_nolabel` renders `date (NN)`, and `age_only` renders just the number. A `year_suffix` checkbox appends a pluralized "year"/"years" via `formatPlural()`. The `date_format` setting is a PHP `date()` format string used to render the accompanying date (hidden by a small jQuery behavior in `js/age_field_formatter.js` when the mode is `age_only`). Output is escaped with `Html::escape()` and `nl2br()`. Settings are stored in the `entity_view_display` component under the schema `field.formatter.settings.age_field_formatter` (`age_format`, `year_suffix`; plus `date_format` and the inherited `timezone_override`). Depends only on core `datetime`.

---

- Display a person's current age in years from a stored birthdate field.
- Show "date (Age: 42)" on a profile using the label mode.
- Show "1983-06-01 (42)" without the "Age:" label using the no-label mode.
- Render age only (just the number) with no date shown.
- Append a "years" suffix that pluralizes correctly (1 year / 42 years).
- Format the accompanying birthdate with a custom PHP date pattern (e.g. `F j, Y`).
- Compute an employee's tenure length in whole years from a start-date field.
- Display the age of a piece of equipment from its purchase-date field.
- Show membership duration in years on a member profile.
- Present age in a Views field by picking the Age formatter on the field's display.
- Add an age column to a teaser or full node view mode for a content type with a date field.
- Show the age of an event's date relative to today.
- Reuse one date field to display both the date and the derived age.
- Hide the date-format option automatically when only the age number is needed.
- Localize the "years" suffix through Drupal's translation/plural system.
- Apply a per-view-mode age display (age-only in teasers, date+age in full view).
- Show animal or livestock age from a birth-date field on a listing.
- Display product/vintage age (e.g. wine, whisky) from a production-date field.
- Report account age in years from a user's join-date datetime field.
- Compute age with timezone handling via the inherited timezone override setting.
