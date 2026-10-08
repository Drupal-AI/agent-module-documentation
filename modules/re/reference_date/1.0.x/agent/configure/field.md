<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the Reference Date Combo field

1. On a fieldable entity, add a field of type **Reference Date Combo** (`reference_date_combo`).
2. **Storage settings** (locked once data exists):
   - `datetime_type` — `date` (date only) or `datetime` (date and time).
   - `end_date` — show a second (end) date column.
   - plus the standard entity-reference target type/bundle settings.
3. **Widget:** `reference_date_combo` autocomplete collects the referenced entity and the date(s).
4. **Formatter:** `reference_date_combo_default` ("Label") renders the referenced entity's label plus formatted `<time>` elements; set the date `format_type` (and optional `timezone_override`) in the formatter settings.

## Data model
Columns: reference `target_id`, `value` (start, `datetime_iso8601`), `end_value` (end). Computed `date` / `end_date` properties expose DrupalDateTime objects. Constraints require both `target_id` and `value`. Rationale: one field instead of Paragraphs/ECK for a reference paired with dates, reducing table/query bloat.
