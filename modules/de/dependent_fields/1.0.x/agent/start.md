<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dependent fields — agent index

Makes one entity-reference field's options depend on another field's value (cascading
dropdowns), via an **Entity Reference Selection** plugin driven by a View. No config page, no
permissions, no Drush, no services. Requires **Views**. Its only persistent state is the child
field's handler settings.

- **Configure a dependent field: the selection handler, its settings keys, requirements, and how the AJAX refresh works** →
  [configure/dependent-field.md](configure/dependent-field.md)

Key facts:
- Selection plugin id: **`dependent_fields_selection`** ("Make field dependent using views"),
  set as the child entity-reference field's *Reference method* (`settings.handler`).
- Handler settings live under **`settings.handler_settings.dependent_fields_view`**:
  `view_name`, `display_name` (must be an *Entity Reference* View display), `parent_field`,
  `reference_parent_by_uuid` (bool), `arguments` (extra View args).
- The View's **first contextual filter** receives the parent field's value.
- Works only with **Select list** or **Check boxes/radio buttons** widgets (not autocomplete);
  supports multi-value fields and Paragraphs subforms.
- Config: `field.field.<entity>.<bundle>.<field>` → `settings.handler` +
  `settings.handler_settings.dependent_fields_view`. Schema
  `entity_reference_selection.dependent_fields_selection`.
