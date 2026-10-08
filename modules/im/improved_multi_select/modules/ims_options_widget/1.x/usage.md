<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IMS Options Widget adds a field widget, **"IMS select list"** (id `ims_options_select`), that behaves like core's Select-list widget but re-orders the option list so previously selected values appear at the top — preserving selection order when paired with Improved Multi Select's re-ordering.

---

The submodule contains a single field widget plugin, `ImsOptionsWidget`, which extends core's `OptionsSelectWidget`. On form build it takes the field's currently selected options and moves them to the front of the `#options` array (in their stored order), then renders a `multiple` `<select>`. This matters because core `list`/`entity_reference` fields do not persist the visual order of a multi-select on the edit form; when you enable Improved Multi Select's "Allow re-ordering of selected items" (`orderable`) option, this widget makes the two-panel picker keep the order the user arranged. The widget explicitly **does not support optgroups** (it flattens grouped values), and it advertises `multiple_values = TRUE`. It applies to the field types `entity_reference`, `list_integer`, `list_float`, and `list_string`. There is no configuration, settings form, permission, config schema, or Drush; you simply select the "IMS select list" widget on a field's *Manage form display*. It depends on core `options` and the parent `improved_multi_select` module.

---

- Keep a multi-value list field's selected items in the order the editor arranged them.
- Pair with Improved Multi Select's re-ordering so the two-panel picker persists order.
- Use on a `list_string` field (e.g. selectable tags) to surface chosen values first.
- Use on a `list_integer` field (e.g. priority levels) with ordered selection.
- Use on an `entity_reference` field rendered as a select list.
- Provide ordered multi-select for a `list_float` field.
- Replace the default Select-list widget where selection order matters.
- Ensure re-saved entities keep the previously chosen order on the edit form.
- Give editors a select widget where their current picks are easy to find (on top).
- Combine with the parent module's search/two-panel UI for large option sets.
- Avoid writing a custom widget just to keep selected options ordered.
- Configure per form mode via Manage form display.
- Apply to taxonomy/user/media entity list fields that need ordered multi-select.
- Migrate a field from the plain select widget to the IMS ordered widget via config.
- Standardise ordered multi-select across several content types.
- Present chosen categories at the top of a long allowed-values list.
- Keep an ordered list of related items on an entity reference field.
- Support editorial workflows where the order of selected options is meaningful.
- Export the widget choice in `entity_form_display` config for deployment.
- Revert to core's `options_select` widget at any time to drop the behaviour.
