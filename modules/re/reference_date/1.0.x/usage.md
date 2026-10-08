<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a single "Reference Date Combo" field type that stores an entity reference plus a start date and, optionally, an end date together in one field.

---

The field type (`reference_date_combo`, extending core's `EntityReferenceItem`) adds `value`/`end_value` ISO-8601 date columns and computed DrupalDateTime properties alongside the reference target. Storage settings choose the date type (date-only or date-and-time) and whether to expose the end-date column. An autocomplete widget (`reference_date_combo`) collects the reference and the date(s), and a "Label" formatter (`reference_date_combo_default`, extending the entity-reference label formatter) renders the referenced entity's label together with formatted `<time>` elements via the `reference_date` Twig template. Constraints require both the target and the start value.

Its purpose is to avoid the table/query bloat of modelling "an entity reference with associated dates" through Paragraphs or ECK — it keeps the pair in one field, simplifying Views and queries. Depends on the core Datetime module. There is no route, permission or global configuration; you add the field to any fieldable entity and configure it through the standard Field UI. The formatter emits values through Drupal's render/`#theme` system with `#html => FALSE` on the date output.

---
- Add a combined entity-reference + date field to a content type
- Store a start date alongside a referenced entity
- Optionally store an end date as well
- Choose date-only or date-and-time storage
- Use the autocomplete widget to pick the referenced entity
- Display the reference label with formatted start/end dates
- Pick a date format for the display formatter
- Override the display timezone for the formatted date
- Avoid Paragraphs/ECK for simple reference+date pairs
- Reduce table joins when querying reference+date data
- Simplify Views that need a reference and a date together
- Require both a reference target and a start date via constraints
- Theme the output via the reference-date.html.twig template
- Generate sample values for testing/dev content
- Model event-like data (item + date range) in one field
