<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Multi-value form element — agent index

Provides ONE Form API render element: `#type => 'multivalue'` (class
`Drupal\multivalue_form_element\Element\MultiValue`, a `FormElementBase`). It wraps child
form elements and repeats them over sortable "deltas" with an AJAX **"Add another item"**
button — the core field-widget multi-value UX for any custom form.

No config, no settings form, no configure route (`configure: null`), no permissions, no
Drush, no config schema, no plugin types of its own. It is a **developer/Form API building
block**, used from a module's `buildForm()`.

- **Use the element in a custom form (properties, children, defaults, required, submitted
  value shape, AJAX)** → [api/multivalue-element.md](api/multivalue-element.md)

Key facts:
- Element id: `multivalue`. Default `#cardinality` = `MultiValue::CARDINALITY_UNLIMITED` (`-1`).
- `#add_more_label` (default "Add another item") labels the add button (unlimited only).
- `#default_value` goes on the wrapper, keyed by numeric delta — never on children.
- On submit: empty deltas dropped, rows sorted by weight, re-keyed; `$form_state` gets a
  clean indexed array keyed by child name.
