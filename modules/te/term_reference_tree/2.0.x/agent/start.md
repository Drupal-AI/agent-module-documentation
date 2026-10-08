<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# term_reference_tree — agent index

Two deliverables, both for **`entity_reference`** fields (in practice taxonomy term
reference, `target_type: taxonomy_term`):

- a **field widget** — plugin id **`term_reference_tree`** (label "Term reference tree"),
  `multiple_values = TRUE`, renders a hierarchical expand/collapse checkbox tree
  (radio buttons when cardinality is 1);
- a **field formatter** — plugin id **`term_reference_tree`** (label "Term Reference
  Tree"), no settings, themes stored values as a nested tree.

There is **no global admin settings form** (`configure` is null), no permissions, no Drush
commands, no plugin type you extend. All configuration lives on a field's *Manage form
display* (widget) or *Manage display* (formatter) component. Widget settings schema:
`field.widget.settings.term_reference_tree`.

- **Apply & configure the tree widget** on a field's form display (settings keys, defaults,
  cascading_selection values, drush/PHP recipe) → [configure/widget.md](configure/widget.md)
- **Plugin ids & the `checkbox_tree` render element** (widget, formatter, form element,
  field types) → [plugins/element.md](plugins/element.md)
- **Programmatic use** — the `checkbox_tree` element and `term_tree_list` theme in custom
  code, helper functions, no hooks/services → [api/render.md](api/render.md)

Facts: widget id `term_reference_tree`; formatter id `term_reference_tree`; render element
`checkbox_tree` (`@FormElement`); field type `entity_reference`; config schema
`field.widget.settings.term_reference_tree`; widget settings `start_minimized` (default
TRUE), `leaves_only` (FALSE), `select_parents` (FALSE), `select_all` (FALSE),
`cascading_selection` (0=none/1=select+deselect/2=only-select/3=only-deselect, default 0),
`max_depth` (0=unlimited). Configure a field to use it by setting its `entity_form_display`
component `type` to `term_reference_tree`.
