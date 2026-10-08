<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Element Multiple (element_multiple) — agent index

A developer/API-only module: it registers **one Form API render element**,
`#type => 'element_multiple'`, and nothing else — no admin UI, no routes, no config,
no permissions, no Drush, no hooks, no `.module` file. Version **1.1.0**, core `^10.5 || ^11`,
PHP `>=8.2`. Plugin: `#[FormElement('element_multiple')]` →
`Drupal\element_multiple\Element\ElementMultiple` (extends `FormElementBase`).

Use it in any `buildForm()` / `hook_form_alter()` to collect a repeatable list of values
(single or composite rows) with AJAX add/remove, drag-sort and cardinality — the multi-value
"Add another" table Drupal otherwise ties to the Field system.

## What it is / isn't
- **Is:** a reusable `#type`. You configure it entirely with `#` properties in a render array.
- **Isn't:** a UI, a field type, a field widget, or anything you enable-and-visit. Enabling the
  module just makes the `#type` available.
- **Value returned:** an array of items (empty items dropped, weight-sorted when `#sorting`,
  keyed by `#key` if set). The **submit handler owns** dedupe/order/storage decisions.

## Solution docs
- [elements/reference.md](elements/reference.md) — every `#` property, single vs composite
  vs `#key` mode, value structure, cardinality/min/empty semantics, states & AJAX internals.
- [elements/examples.md](elements/examples.md) — copy-paste recipes (simple list, composite
  table, capped emails, unique-keyed map, hidden per-row id, required list).

## Gotchas to check in any integration
1. **Add/remove after a validation error** must preserve typed rows — the module keeps the row
   count in `$form_state` and rebuilds; test it.
2. **`#cardinality` is enforced server-side** — the add handler re-clamps a crafted "add N"
   POST; the browser `#max` is not a trust boundary.
3. **`#key` mode** requires the named sub-element's value to be **unique** (validated) and
   turns the result into an associative array keyed by it.
4. Add/remove controls are core **`#ajax`** submit/image buttons, so CSRF form tokens are
   handled by core.
