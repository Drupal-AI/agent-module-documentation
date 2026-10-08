<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Field - Entity Browser — agent index

Adds one `custom_field_widget` plugin, **`entity_reference_entity_browser`**, for Custom
Field **`entity_reference`** columns. No config entity, route, permission, or Drush.

- **Select & configure the Entity Browser widget on an entity_reference column (settings
  keys, where stored, scriptable)** → [configure/entity-browser-widget.md](configure/entity-browser-widget.md)

Key facts:
- Widget id `entity_reference_entity_browser` (class `EntityReferenceBrowserWidget`,
  `field_types: ['entity_reference']`, cardinality-1 only).
- Stored on the form-display component at `settings.fields.<column>.type =
  entity_reference_entity_browser`, with sibling keys `entity_browser` (the Entity Browser
  instance id), `field_widget_display` (default `label`), `field_widget_display_settings`,
  `open`, `field_widget_edit`, `field_widget_remove`, `field_widget_replace`.
- Those keys are injected into the `custom_field.field.*` schema by
  `hook_config_schema_info_alter()` in `ConfigSchemaHooks`.
- The parent Custom Field must have an `entity_reference` column (column setting
  `target_type`, e.g. `node`) for the widget to be offered.
