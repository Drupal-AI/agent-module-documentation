<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Key/Value Field adds two Drupal field types that store a **key**, a **value**, and an optional **description** in a single field item, with matching widgets and a formatter.

---

The module provides two field types, both grouped under the "Key / Value" field category: `key_value` (**Key / Value (plain)**, extending core's `StringItem`, plain-text value) and `key_value_long` (**Key / Value (long)**, extending `TextLongItem`, formatted/filtered value with a text format). Each item stores three properties — `key`, `value`, and an optional `description` — persisted as extra `key` and `description` DB columns added to the base string/text schema (the `key` column is indexed and its length is set by the `key_max_length` storage setting, default 255). Two widgets ship: `key_value_textfield` (default for the plain type) and `key_value_textarea` (default for the long type); both expose settings for the key label/size/placeholder, the value label, and whether the description sub-field is enabled (with its own label, rows, and placeholder). The `key` is conditionally required — it becomes mandatory only when a value has been entered (enforced by a `#states` rule and a `validateKeyElement` handler). A single formatter, `key_value`, extends the core text formatter and adds a `value_only` boolean setting to render just the value and hide the key. There is no admin settings page, no permission, and no Drush command — everything is configured per field on the bundle's *Manage fields / form display / display* pages.

---

- Store a labelled attribute like "SKU: ABC-123" as a single field on a product node.
- Capture spec sheets (key = spec name, value = spec value) with an admin-only description per row.
- Add repeatable key/value metadata rows to a content type (set field cardinality > 1).
- Record "Ingredient : Amount" pairs on a recipe with a note in the description.
- Store formatted (rich-text) values by using the `key_value_long` type instead of the plain one.
- Present configuration-style settings ("Warranty : 2 years") on an entity edit form.
- Hide the key on output and show only the value by ticking the formatter's "Value only" setting.
- Give editors a friendlier UI with custom key/value/description labels per field instance.
- Cap key length for a code-like key by lowering the `key_max_length` storage setting.
- Use an ASCII-only, indexed key column for faster lookups (`key_is_ascii` storage setting).
- Add a placeholder hint in the key field to guide editors on the expected format.
- Collect FAQ-style "Question : Answer" entries where the description holds editor notes.
- Store contact rows like "Phone : +1..." with a description explaining which line it is.
- Attach arbitrary labelled data to taxonomy terms, users, or media via a key/value field.
- Make the key required only when a value is filled in, avoiding spurious required errors.
- Turn off the description sub-field entirely for a simpler two-input widget.
- Give the description a custom number of textarea rows for longer notes.
- Default the text format of new `key_value_long` items via the field's `default_format` setting.
- Migrate legacy "attribute name / attribute value" data into structured field items.
- Build a glossary where key = term and value = definition, rendered inline.
- Display "Label : Value" pairs consistently across many content types using one reusable field type.
- Store per-node feature flags or badges as key/value rows without a custom entity.
- Keep an internal-only description alongside a public value that editors can reference.
