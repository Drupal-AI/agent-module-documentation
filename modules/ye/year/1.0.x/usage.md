Year provides a single-value field type that stores only a year as an unsigned integer, with a configurable valid min/max range (the max may be a relative expression like `now` or `+5 years`), a textfield widget and a select-list widget, and a plain formatter. An optional `year_views` submodule adds a dropdown exposed Views filter for year fields.

---

The `year` field type (`YearItem`, extends `NumericItemBase`) stores one unsigned `int` column and adds two range constraints derived from its field settings: `min` (integer, default 1900) and `max` (string — a specific year OR a PHP relative-time expression resolved to a year via `strtotime()`/`date('Y')`). Two widgets ship: `year_default` (a plain textfield) and `year_select` (a select list built from `range(min, max)` with a configurable ascending/descending sort order). The `year_default` formatter renders the stored integer as markup. A field default value may itself be a relative expression (e.g. `now`, `+5 years`), evaluated at the same range. A `Feeds` target plugin (`Year`) lets the field be populated during Feeds imports. The submodule **year_views** provides a `year_field` Views filter (extends `ManyToOne`) whose exposed dropdown options are generated from a configurable `year_from`/`year_to` range (also accepting relative expressions, defaults `-30 years`…`+15 years`) with a sort-order option — giving site builders a friendly year dropdown instead of a free-text numeric filter. No permissions, no config UI (`configure` is null); everything is configured on the field's storage/instance settings and Manage form/display tabs.

---

- Add a "Year built" field to a Property content type storing only the year.
- Collect a person's birth year without a full date field.
- Store a copyright / publication year on articles.
- Constrain input to years from 1900 to the current year using `min` and a `now` max.
- Allow future years (e.g. event planning) with a `+5 years` relative max.
- Support historical years (e.g. `min` 530) for archival content.
- Present the year as a dropdown select list instead of a text box.
- Sort the year select list descending so recent years appear first.
- Set a default year of "current year" using the `now` relative default value.
- Set a default of five years ahead with `+5 years`.
- Validate submitted years against the configured range automatically (Range constraints).
- Render the year as plain text with the default formatter.
- Import year values from a CSV/RSS source via the Feeds target plugin.
- Generate sample year values for test content (`generateSampleValue`).
- Add a user-friendly exposed "Year" dropdown filter to a View (year_views submodule).
- Bound the exposed Views year filter to a relative range like `-30 years` to `+15 years`.
- Offer ascending or descending ordering of the exposed Views year dropdown.
- Replace a free-text numeric Views filter with a curated list of valid years.
- Use the field on any fieldable entity (nodes, taxonomy terms, users, paragraphs).
- Keep storage compact by using a single unsigned integer column instead of a date string.
