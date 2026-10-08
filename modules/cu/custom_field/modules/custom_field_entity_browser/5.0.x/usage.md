<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Field - Entity Browser adds an **Entity Browser** input widget (`entity_reference_entity_browser`) for `entity_reference` columns of a Custom Field, letting editors pick the referenced entity through an Entity Browser instead of an autocomplete.

---

This submodule registers a single `custom_field_widget` plugin, `entity_reference_entity_browser` (class `EntityReferenceBrowserWidget`, category *Reference*), that serves the parent module's `entity_reference` subfield type. It is a cardinality-1 adaptation of Entity Browser's core reference widget: on a Custom Field's *Manage form display*, an `entity_reference` column can choose this widget and then configure which **Entity Browser** instance to open (`entity_browser` setting), how selected entities are shown (`field_widget_display`, default `label`, with `field_widget_display_settings`), whether the browser opens inline (`open`), and whether edit/remove/replace buttons appear (`field_widget_edit`, `field_widget_remove`, `field_widget_replace`). Those keys are added to the `custom_field.field.*` config schema via `hook_config_schema_info_alter()` and stored on the form-display component under `settings.fields.<column>`. It has no config entity, route, permission, or Drush of its own — enabling it simply makes the widget selectable wherever a Custom Field has an `entity_reference` column.

---

- Let editors select a referenced node for a Custom Field `entity_reference` column via an Entity Browser modal.
- Replace the default autocomplete on a Custom Field reference column with a visual browser.
- Pick media items for a reference column through a media Entity Browser.
- Configure which Entity Browser instance opens for a specific Custom Field column.
- Show the selected entity as a rendered view mode rather than a plain label using `field_widget_display`.
- Show selected entities as labels (the default `field_widget_display: label`).
- Open the Entity Browser inline on the form instead of in a modal by setting `open`.
- Allow editors to remove a selection with the remove button (`field_widget_remove`).
- Allow editors to replace a selection with the replace button (`field_widget_replace`).
- Allow inline editing of the referenced entity via the edit button (`field_widget_edit`).
- Curate a "featured content" Custom Field where each row references a chosen entity.
- Build a compound field (reference + caption + weight) where the reference is chosen via Entity Browser.
- Standardise editorial selection UX across many Custom Fields by reusing one Entity Browser.
- Constrain reference selection to a specific Entity Browser's view/query instead of raw autocomplete.
- Deploy the widget choice as config (`settings.fields.<column>.type: entity_reference_entity_browser`).
- Switch a Custom Field reference column between autocomplete and Entity Browser per form mode.
- Use an existing Entity Browser instance (e.g. a media library browser) for a Custom Field reference.
- Give a reference column a friendlier selection UI for non-technical editors.
- Reference taxonomy terms or users through an Entity Browser in a Custom Field column.
- Keep referenced-entity display settings alongside the widget in exported configuration.
- Provide a single-value entity picker (the widget is hardcoded to cardinality 1) inside a multi-value Custom Field.
