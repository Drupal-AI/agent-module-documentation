<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Multi-value form element provides a single reusable Form API render element, `#type => 'multivalue'`, that wraps one or more child form elements and lets a user add, remove, sort, and repeat them over multiple deltas — the "add another item" pattern of core field widgets, made available to any custom form.

---

The module ships exactly one thing: a `FormElementBase` plugin (`Drupal\multivalue_form_element\Element\MultiValue`) registered as the `multivalue` element type. You declare child elements directly inside a `multivalue` element (a single child, or several named children per row), and the element repeats those children per "delta", exactly like a multi-value field widget. `#cardinality` controls how many rows are allowed — a positive integer, or `MultiValue::CARDINALITY_UNLIMITED` (`-1`, the default) which renders an AJAX **"Add another item"** button (its label overridable with `#add_more_label`). Default values are passed on the wrapper as `#default_value`, keyed by numeric delta (with a shorthand for the single-child case); never on the children. The element is `#required`-aware in a field-like way: required applies only to the first delta. On submit it cleans itself up — empty deltas are dropped, remaining deltas are re-sorted by their per-row weight and re-keyed consecutively, so `$form_state` always receives a tidy indexed array of rows keyed by child name. There is **no configuration, no settings form, no permissions, no Drush, and no config schema**: it is a pure developer/Form API building block, used from custom module form code (`buildForm()`), not from the admin UI.

---

- Collect an unlimited list of simple strings on a custom form (e.g. a list of job titles) with an "Add another item" button.
- Collect an unlimited list of grouped rows, e.g. name + e-mail pairs, each row containing several child elements.
- Cap the number of rows with `#cardinality` (e.g. allow at most 3 phone numbers).
- Offer an unlimited-cardinality repeater that renders the AJAX add-more button automatically.
- Relabel the add button per element with `#add_more_label` (e.g. "Add another contact").
- Pre-populate a repeater with existing values via `#default_value` keyed by delta.
- Use the single-child shorthand `#default_value => ['Foo', 'Bar']` when a `multivalue` has just one child.
- Build a settings form section where an admin enters an arbitrary number of key/value mappings.
- Let editors enter a variable-length list of URLs, redirects, or synonyms in a config form.
- Reproduce the field-widget "delta" UX (draggable weight per row) without defining an actual field.
- Make only the first row required (`#required` on the wrapper) while extra rows stay optional.
- Keep specific child columns required across all rows by combining `#states` with the element.
- Gather repeating structured data in a batch/import configuration form.
- Build a custom "add many" step in a multistep form or wizard.
- Replace hand-rolled "add more" AJAX callbacks in bespoke forms with a maintained, tested element.
- Collect several file/media reference IDs, taxonomy terms, or entity IDs as repeated inputs.
- Capture an ordered list where row order matters, relying on the built-in weight sorting.
- Let the submit handler receive a clean, consecutively-keyed array with empty rows already removed.
- Nest a `multivalue` element inside containers or other structures (button names/AJAX wrappers are derived from `#parents`).
- Provide a repeatable group of checkboxes/select/number inputs inside one logical field.
- Prototype data-entry UIs quickly without creating field storage or entity fields.
- Build admin-facing mapping tables (e.g. "when value X, do Y") as repeatable rows.
- Gather a dynamic list of conditions/rules in a custom rules or workflow form.
- Standardise the multi-row UX across many custom forms in a project by reusing one element type.
- Collect repeating address blocks or contact blocks with multiple sub-fields each.
- Use it inside a plugin or block configuration form that needs a variable number of entries.
