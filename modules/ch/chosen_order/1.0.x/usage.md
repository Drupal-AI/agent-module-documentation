<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chosen Order

Adds drag-to-reorder to multi-value Chosen select widgets so the chosen order is preserved.

---

## Install & configure

- Requires the contrib **Chosen** and **Chosen Field** modules plus core's `jquery_ui_sortable`.
- `composer require drupal/chosen_order` then `drush en chosen_order -y` (deps must be present).
- No settings form and no permissions — it activates automatically on qualifying fields.
- It only attaches to widgets where `#chosen` is set and the field is `#multiple`.
- Uses `hook_field_widget_form_alter` to attach the `chosen_order/drupal.chosen_order` library and an element validate handler.

---

## Usage & behaviour

- Reorder multi-value entity-reference or list fields (rendered with Chosen) by dragging the selected chips.
- Preserve a meaningful order of selections (e.g. ranked tags, ordered related content).
- Order is persisted: a hidden `<field>_order` element stores a comma-separated list of values on submit.
- On page load the JS re-sorts the Chosen chips to match the previously saved order.
- The validate handler (`chosen_order_form_chosen_field_validate_order`) rewrites the field's submitted values into the dragged order.
- Sorting is powered by jQuery UI Sortable on the `.chosen-choices` list.
- Order updates on drag, on add (change event) and on removing a choice.
- Works only with multiple-value select widgets; single selects are ignored.
- No effect if Chosen is not enabled on the widget.
- Useful for building manually ordered lists without a dedicated weight/table field.
- The hidden order field is keyed by the field's storage key column (e.g. `target_id`).
- Reordering is client-side; the final order is what the validate handler writes to storage.
- Attach is idempotent via `once('chosen-order-init', ...)`.
- Pairs naturally with Chosen Field's per-field Chosen enablement.
- No configuration UI — behaviour is entirely automatic once dependencies are met.
