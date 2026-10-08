<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Triple field adds one field type, `triples_field`, whose every item stores three separate, independently-typed sub-values — `first`, `second` and `third` — on any entity, with widgets and formatters to edit and display all three together.

---

Despite the name, this has nothing to do with RDF or semantic-web triples. "Triple" simply means *three columns in one field*. The module is a near-verbatim three-column fork of the well-known **Double Field** module (all credit to its maintainer, @chi): where Double Field stores `first` and `second`, this stores `first`, `second` and `third`, and the codebase is otherwise the same design. Each of the three sub-fields is independently configured to one of eleven storage types — boolean, plain text, long text, formatted long text, integer, float, decimal, email, telephone, date, or URL — set on the field-storage settings form and **locked once the field holds data**. Per-instance you then choose a widget for each sub-value (textfield, textarea, checkbox, select, radios, number, range, email, tel, url, color, date picker), whether each is required, min/max for numbers, and an optional allowed-values list that turns a sub-field into a select/radios. Display is handled by four formatters — a single-row **Table** (the default), a **Details** disclosure, an **HTML list** (ul/ol/dl) and an **Unformatted list** — each of which can hide a sub-value, show its label, render numbers/dates with format options, and turn email/telephone/URL values into `mailto:` / `tel:` / external links. The three sub-field machine names (`first`/`second`/`third`) and their admin titles live in a single site-wide config object, `triples_field.settings`; there is no admin form to change them. The field exposes `first`/`second`/`third` as typed-data properties with **no main property** (`mainPropertyName()` is `NULL`, so there is no `->value`), ships a Feeds target mapping each sub-value, and provides all its own config schema. Use it when you want three related values kept together on an entity — a label plus a value plus a note, a term plus two attributes, a name/amount/date row — without the overhead of Paragraphs or a custom compound field. For more than three columns the author points you at the **Data field** module.

---

- Store three related values in one field instead of three separate fields.
- Add a label + value + note triplet to nodes, users, taxonomy terms or any entity.
- Model a simple key / value / description row without Paragraphs.
- Build a repeatable multi-value list of three-column rows (unlimited cardinality, drag-to-reorder).
- Render the three values as a compact single-row table per item (default formatter).
- Display the triplet as a collapsible Details element with the first value as its title.
- Show items as an unordered, ordered or definition list.
- Mix types per column — e.g. a text label, a decimal amount and a date.
- Turn a column into a select list or radio buttons via an allowed-values list.
- Make an email column render as a clickable `mailto:` link.
- Make a telephone column render as a `tel:` link.
- Make a URL column render as an external link.
- Format a numeric column with a chosen scale, decimal marker and thousands separator.
- Format a date column with any configured Drupal date format.
- Require some columns and leave others optional.
- Constrain a numeric column with min/max range validation.
- Give a long-text column a full CKEditor (formatted, long) with a text format.
- Hide one column in a given view mode while keeping it stored (useful for Views).
- Import three-column data from CSV/feeds via the bundled Feeds target.
- Show or hide per-column labels independently in each formatter.
- Replace a two-column Double Field with a three-column equivalent.
- Store a contact triplet such as name / email / phone on a profile entity.
- Record a spec row such as attribute / value / unit on product content.
- Reorder multi-value triplets by weight in the table widget.
- Display the value or, for list columns, the raw key instead of the label.
- Keep three values atomic so they move, translate and revision together as one field.
