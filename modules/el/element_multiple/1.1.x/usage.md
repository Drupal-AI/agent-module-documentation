<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Element Multiple adds one Form API render element, `#type => 'element_multiple'`, that gives a plain custom form the multi-value "Add another" table (AJAX add/remove, drag-sort, cardinality) that Drupal normally reserves for field widgets — no admin UI, no config, developer-only.

---

Drupal's repeatable-row pattern (a table of inputs, an "Add" button, per-row remove, drag handles) is welded to the **field** system; a settings form, a config-entity form or any custom form that needs a list of emails, endpoints or key/value pairs has to hand-roll it, and doing it correctly is more work than it looks (the row count must live in `$form_state`, the AJAX rebuild must preserve typed values, the wrapper needs a stable id, and it all has to survive validation errors without wiping input). This module packages that as a plugin — a `#[FormElement('element_multiple')]` class extending `FormElementBase` — so it becomes a single `#type` declaration. The repeated input is defined by `#element`: give it one element (default is a `textfield`) for a simple list, or an associative array of named sub-elements (with `#header => TRUE` or a `#header` array) for a composite row of columns; sub-elements may themselves be containers/nested. Control the collection with `#cardinality` (int, or `FALSE`/`-1` unlimited), `#min_items`, `#empty_items`, `#add_more`/`#add_more_items`/`#add_more_input`, `#sorting` (drag weight), `#operations`/`#add`/`#remove` (the per-row +/- image buttons) and `#key` (name a sub-element whose value becomes the associative array key, validated unique). The **returned value is an array of items** the submit handler owns: empty items are dropped automatically, weight-sorted when `#sorting`, and either sequential or keyed by `#key`; whether order matters, whether to dedupe, and how to store them are the consumer's decisions. Two behaviours worth testing in any integration: adding/removing a row **after a failed validation** (values must persist — the module keeps them in form state), and the server-side clamp of `#cardinality` (the add handler re-clamps a crafted "add N" POST, so the browser `#max` is not a trust boundary). Add/remove buttons use core `#ajax`, so form-token CSRF is handled by core. Requires PHP 8.2+ and core `^10.5 || ^11`; installed version 1.1.0.

---

- Collect several email addresses in a module settings form.
- Add an "Add another" repeatable row to a custom form without hand-rolling AJAX.
- Build a list of API endpoints or webhook URLs in configuration.
- Collect key/value pairs where the key must be unique (via `#key`).
- Gather a composite list of rows (e.g. first name + last name columns) with `#header`.
- Cap a list at N entries with `#cardinality` and hide the "add" controls when full.
- Require at least one entry with `#required` / `#min_items`.
- Let editors drag to reorder items and have the order preserved (`#sorting`).
- Store an ordered list of allowed hosts or redirect paths.
- Collect several phone numbers or recipients on a contact/notification form.
- Build an options list (value + label + score) as a keyed associative array.
- Include a hidden per-row id/value (`#type => 'value'`) that travels with each item.
- Add "Add N more items" bulk-add with a numeric count input.
- Reuse one multi-value widget across many forms instead of copying add-more code.
- Collect a variable-length list of identifiers, tags or codes.
- Preserve typed rows across a validation error (add/remove after a failed submit).
- Attach per-sub-element `#states` (conditional required/visible) inside repeated rows.
- Build a config-entity form field that Field UI cannot express.
- Reduce form boilerplate and the classic "Add another clears the rows above" bug.
- Restore values of `#disabled` sub-elements the browser would not submit (via `#key`).
