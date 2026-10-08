Field Select Filter adds a Views exposed filter that populates a dropdown with the distinct values actually stored in a single text or integer field, so site visitors filter by picking a real value instead of typing one.

---

On `hook_views_data_alter`, the module scans every `string` and `integer` **field_config** and, for each, registers a second filter handler alongside the field's normal filter, labelled "<Field label> (selector)". That handler is the `fieldselect` plugin (`FieldSelectFilter`, extending core's `InOperator`), whose value form is a `select`/multi-select. When the filter is exposed, `getValueOptions()` runs a `SELECT DISTINCT <field>_value` query against the field's data table and uses the returned values as the dropdown options; if the View also filters on content type, the option query is scoped to those bundles. Two extra expose settings are added: **Value order** (ASC/DESC) and, on multilingual sites, **Options in current language only** (adds a `langcode` condition). The filter is only meaningful when exposed — its non-exposed value form is intentionally empty. There is no configuration UI, no permission, and no schema; you simply add the "(selector)" filter to a View.

---

- Turn a free-text "Department" string field into an exposed dropdown of the departments that exist.
- Let visitors filter a listing by a single-value taxonomy-like string field without a taxonomy.
- Build a select filter over an integer field (e.g. year, rating, capacity) from real stored values.
- Provide a "pick from existing values" UX instead of an exact-match text box in an exposed filter.
- Populate the dropdown only with values that are actually present, avoiding empty result sets.
- Scope the dropdown options to the content types the View already filters on.
- Offer multi-value selection (IN operator) so users can choose several values at once.
- Sort the exposed dropdown options ascending or descending via the Value order setting.
- On a multilingual site, show only option values in the current interface language.
- Replace a manually-maintained "allowed values" list with an auto-derived one.
- Add per-field filters for many string/integer fields at once (one "(selector)" filter appears per field).
- Give editors a quick faceted-style single-field filter on an admin View of content.
- Filter a directory/listing by a stored code or SKU-like string field via dropdown.
- Let users filter events by a stored integer field such as edition number.
- Build a location filter from a plain-text city field populated by content authors.
- Provide a status/label dropdown sourced from a custom string field.
- Avoid teaching editors exact spellings — they select the exact stored value.
- Combine with other exposed filters for a lightweight browse experience.
- Expose a filter whose options grow automatically as new field values are entered.
- Use as a simpler alternative to Search API facets for a single low-cardinality field.
