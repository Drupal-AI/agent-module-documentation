<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Numeric Range adds three Drupal field types — `range_integer`, `range_decimal` and `range_float` — that store a FROM and a TO number in one field, plus a two-input widget, five display formatters and Views filter/argument handlers.

---

The module is modelled on core's Number module but stores **two** columns per field item, `from` and `to`, so a single field can hold "14–60" or "12.34–56.78". Because `mainPropertyName()` returns NULL, neither sub-value is privileged: both are required properties, and two validation constraints (`RangeBothValuesRequired`, `RangeFromGreaterTo`) are attached to every range item so a range cannot be half-filled or inverted. Field settings add `min`/`max` bounds plus four independent prefix/suffix pairs — `field`, `from`, `to` and `combined` — that let you render `$10 – $50 per night` without touching a template. The `range` widget renders two `number` inputs (with the right `#step` for decimal/float) side by side in a fieldset. Five formatters ship: `range_integer` and `range_decimal` (labelled "Default", differing only in the decimal/scale settings they expose), `range_integer_sprintf` and `range_decimal_sprintf` ("Formatted string", using a PHP `sprintf` `format_string`), and `range_unformatted`. All of them share a `range_separator` and a `range_combine` toggle that collapses a range into a single value when FROM equals TO, and four checkboxes deciding which prefix/suffix pair is displayed. Output goes through two Twig templates, `range-formatter-range-combined.html.twig` and `range-formatter-range-separate.html.twig`. `hook_field_views_data()` adds a "range filter" and a "range argument" per range field, both using the `within` / `not within` operators to ask "does this stored range contain value X?". The module has no settings form, no configure route, no permissions, no services and no Drush commands; it also ships D6/D7 migrate field and process plugins.

---

- Store a hotel or product **price range** ("from $80 to $220") in a single decimal field.
- Capture a **target age range** for an event or a toy ("6–12 years") as one integer field.
- Record a **salary band** on a job posting entity and render it as `€45,000 – €60,000`.
- Model an **opening-hours span** or "estimated delivery 3–5 days" without two separate fields.
- Hold a **temperature range** for a recipe or a storage requirement using `range_float`.
- Express a **course duration** ("2–4 hours") with a combined display when both ends match.
- Store a **weight or size range** for a product variation with the `to` suffix set to `" kg"`.
- Build a Views filter that finds every product whose stored price range **contains** a visitor-supplied number.
- Build the inverse filter — list entities whose range does **not** contain a value — with the `not within` operator.
- Expose that range filter to site visitors as a "price I can afford" exposed filter.
- Use the range **Views argument** so `/products/150` lists everything whose range covers 150.
- Bound editor input with `min`/`max` field settings so a percentage range can never leave 0–100.
- Prevent inverted data entry: `RangeFromGreaterTo` rejects a saved item whose FROM exceeds its TO.
- Force complete data: `RangeBothValuesRequired` rejects an item with only one end filled in.
- Display `1,000-5,000` with a thousand marker by setting `thousand_separator` on the Default formatter.
- Render a range as `007–042` using the "Formatted string" formatter with `format_string: '%03d'`.
- Show two decimals with a comma decimal marker for a European locale via `decimal_separator`.
- Collapse "50–50" down to a single "50" on the rendered page with `range_combine`.
- Give the collapsed value its own wording ("flat $50") through the COMBINED prefix/suffix pair.
- Relabel the edit form inputs from "From/to" to "Shortest/Longest" in the widget settings.
- Add placeholders to both range inputs to hint at the expected format on a long entity form.
- Emit raw, unformatted numbers for a machine-readable display mode with `range_unformatted`.
- Override `range-formatter-range-separate.html.twig` in a theme to wrap each end in its own markup.
- Migrate Drupal 6 or Drupal 7 range fields, settings and formatter settings using the bundled migrate plugins.
- Attach a range to any fieldable entity — media, taxonomy terms, users, paragraphs — not just nodes.
- Store a page-count range on a bibliography entity and print it with an en-dash separator.
