<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type `EntityViewModeFieldPlugin` (the API to extend)

## Discovery / manager
- Manager: `EntityViewModeFieldPluginManager` (`src/Plugin/EntityViewModeFieldPluginManager.php`),
  extends `DefaultPluginManager`. Service id `plugin.manager.entity_view_mode_field_plugin`
  (`entity_view_mode_field_plugin.services.yml`, parent `default_plugin_manager`).
- Discovery subdir `Plugin/EntityViewModeFieldPlugin`; interface
  `EntityViewModeFieldPluginInterface`; annotation `EntityViewModeFieldPlugin`.
- Alter hook: `hook_entity_view_mode_field_plugin_entity_view_mode_field_plugin_info(&$definitions)`.
  Cache cid `entity_view_mode_field_plugin_entity_view_mode_field_plugin_plugins`.
- Extra method `getDefinitionsByEntityType($entity_type_id)`: returns **instantiated** plugins whose
  `entity_type` list is empty or contains `$entity_type_id`.

## Annotation (`src/Annotation/EntityViewModeFieldPlugin.php`)
- `id` (string), `label` (Translation), `entity_type` (array; **empty = applies to all** content
  entity types), `field_key` (string) — `field_key` is declared but **unused** by the shipped
  plugins and hooks.

## Base / interface
- `EntityViewModeFieldPluginInterface` extends `PluginInspectionInterface` and declares no methods.
- `EntityViewModeFieldPluginBase` extends `PluginBase` and defines
  `getValue(EntityInterface $entity): mixed` (default returns `[]`). Subclasses override `getValue()`
  to return the computed value.

## The two hooks (`entity_view_mode_field_plugin.module`)
- `hook_entity_extra_field_info()`: iterates every `ContentEntityTypeInterface` and each of its
  bundles; for each plugin whose `entity_type` is empty or includes the type, registers a **display**
  extra field keyed by the plugin `id`:
  `label` = `t('@entity_type_name ' . $plugin['label'], …)`, `weight` = 5, `visible` = FALSE. So the
  rows appear on *Manage display* but are hidden by default. The module does **not** implement a
  `hook_entity_view`/render, so it does not itself output these fields into HTML.
- `hook_entity_load(array $entities, $entity_type_id)`: gets the applicable plugins via
  `getDefinitionsByEntityType()` and sets `$entity->{$plugin_id} = $plugin->getValue($entity)` on
  every loaded entity — a **dynamic object property**, readable in code (e.g. `$node->entity_uuid`)
  and available to normalizers.

## Add your own plugin
Create `src/Plugin/EntityViewModeFieldPlugin/MyField.php` extending
`EntityViewModeFieldPluginBase`, annotate with a unique `id`, a `label`, and an optional
`entity_type` list, and override `getValue()` to return your value. Clear caches so discovery and
the extra-field info pick it up.
