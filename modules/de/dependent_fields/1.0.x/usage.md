<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Dependent fields lets one entity-reference field's selectable options depend on the value of another field on the same form: pick a value in the "parent" field and a child reference field's options are re-filtered via a View, AJAX-refreshed without a page reload (classic cascading/chained dropdowns).

---

The module works by adding an **Entity Reference Selection** plugin, `dependent_fields_selection` ("Make field dependent using views"). You set the child entity-reference field's *Reference method* to this handler on the field's settings form; its `handler_settings.dependent_fields_view` records the **View name + display** (must be an *Entity Reference* display), the **parent field** the child depends on, an optional **reference-parent-by-UUID** flag, and optional extra **View arguments**. The referenced View must take the parent's value as its first **contextual filter (argument)**, so it returns only the entities valid for that parent. On any entity edit form, `hook_field_widget_single_element_form_alter()` detects that a field names another as its parent and attaches an AJAX `change` handler to the parent widget; when the parent changes, `ViewsSelection::updateDependentField()` re-executes the View with the new parent value and replaces the child field's options (via a custom `UpdateOptionsCommand` / `updateOptionsCommand` JS command, or a `ReplaceCommand` for the `select_tagify` widget). It supports single and multi-value fields, works inside **Paragraphs** subforms, and can reference the parent by entity ID or UUID (for config portability). Important: it only works with **Select list** or **Check boxes/radio buttons** form widgets, **not** the autocomplete widget (which merely gets an `autocompleteclose` event). It provides no configuration page, no permissions, no Drush, and no services of its own; all state lives in the child field's `field_config` handler settings (config schema `entity_reference_selection.dependent_fields_selection`). Views is required.

---

- Build a country → state/province → city cascade of dependent dropdowns.
- Filter a "Model" field's options by the selected "Manufacturer".
- Show only the "Sub-category" terms that belong to the chosen "Category".
- Limit a "Team" reference field to members of the selected "Department".
- Make a "City" select depend on a "Region" reference field on a content form.
- Chain product "Variant" options to the selected "Product".
- Restrict "Course modules" to those in the picked "Course".
- Filter "Project tasks" by the chosen "Project".
- Cascade "Building → Floor → Room" reference selects on a facilities form.
- Narrow a large entity-reference list down to a manageable, context-relevant set.
- Depend a child field on a parent field inside a Paragraphs subform.
- Use UUID-based parent references so the config exports cleanly between environments.
- Pass extra static View arguments alongside the parent value to further filter options.
- Keep multi-value dependent select fields multi-value even when initially empty.
- Drive dependent options from any View with an Entity Reference display and a contextual filter.
- Replace custom JS/States-based chained selects with a config-only solution.
- Filter "Speakers" to those assigned to a selected "Session".
- Constrain "Assignee" options to users in the selected "Group".
- Build a taxonomy-driven faceted content-entry form (parent term filters child terms).
- Limit "Warehouse stock" items to the selected "Warehouse".
- Present only "Document templates" valid for the chosen "Document type".
- Cascade "Supplier → Catalog item" selections on an order form.
- Filter reference options with `select_tagify` widgets via the tagify-aware replace path.
- Reduce data-entry errors by only offering valid child options for each parent.
