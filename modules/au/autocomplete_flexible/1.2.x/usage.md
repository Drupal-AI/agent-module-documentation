<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Autocomplete Flexible provides a customizable autocomplete form element and an entity-reference field widget whose behaviour and rendering can be overridden through a JavaScript plugin.

---

The core piece is the `autocomplete_flexible` render/form element (`src/Element/AutocompleteFlexible.php`), a `FormElementBase` that supports single or multiple (unlimited-cardinality) selections, a hidden value field plus a visible textfield, a `|` value separator, and a minimum trigger length of 3 characters. It reuses Drupal's standard `#autocomplete_route_name`/`#autocomplete_route_parameters` plumbing but adds `#flexible_default_value` and `#flexible_options` so the bundled JS plugin (`js/plugin/autocomplete-flexible.js`) can alter values before submission and be reconfigured per-instance. On top of the element sits `EntityReferenceAutocompleteFlexibleWidget`, a field widget you select in Manage form display for entity-reference fields. Modules can alter the label shown for a selected item via `hook_autocomplete_flexible_widget_label(&$label, $form_state, $context)` (documented in `autocomplete_flexible.api.php`).

The module itself defines no routes, permissions, or services — it is purely a field/form building block, so its security posture is inherited from the entity-reference autocomplete route it wraps (core access checks on the referenced entities). The optional `examples` submodule ships a demo controller, form, and library showing the element and widget in use.
---
Use a flexible autocomplete widget on an entity-reference field.
- Allow selecting multiple referenced entities in one field.
- Support unlimited-cardinality entity reference selection.
- Render selected items as a removable list.
- Override the autocomplete JS behaviour via `#flexible_options`.
- Set an initial value that JavaScript can alter before submit.
- Reuse core autocomplete routes with custom parameters.
- Customize the displayed label of a selected item via the alter hook.
- Add the element to a custom form with `#type => autocomplete_flexible`.
- Set a minimum character length before suggestions appear.
- Separate stored values with the `|` separator.
- Choose the widget in Manage form display for a reference field.
- Provide a themable wrapper/textfield/selected-list markup.
- Reference nodes, taxonomy terms, users, or any entity type.
- Study the examples submodule for a working controller and form.
- Reconfigure the JS plugin options per field instance.
- Alter labels differently per field via the `$context['field_name']`.
- Build a tag-style multi-select entry experience.
- Keep the underlying value hidden while showing friendly labels.
