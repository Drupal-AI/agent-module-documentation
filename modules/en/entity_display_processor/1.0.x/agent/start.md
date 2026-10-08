<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Display Processor (entity_display_processor) — agent index

Defines a **plugin type** ("Entity display processor") whose plugins post-process the render array
of an entity for a chosen **view mode**. A `hook_entity_view_alter()` implementation loads the one
processor configured on the `entity_view_display` config entity (as a third-party setting) and runs
its `process()` over the build. Field UI's *Manage display* form gets a selector to pick and
configure that plugin. Version **1.0.0-beta2** (version-dir `1.0.x`). Core `^11`, **PHP 8.3**.
License GPL-2.0-or-later. **No dependencies, no permissions, no routes, no settings page, no Drush.**

- **The plugin type, manager, interface, attribute + the bundled `custom_classes` plugin, and how to write your own** →
  [plugins/entity_display_processor.md](plugins/entity_display_processor.md)
- **How config is stored & the Manage-display UI (hooks, drilldown element, third-party settings, schema)** →
  [config/display.md](config/display.md)

## What it actually is (from source)

- Plugin type `Plugin/EntityDisplayProcessor`, interface
  `Plugin\EntityDisplayProcessorInterface` (single method
  `process(array $element, EntityInterface $entity): array`), attribute
  `Attribute\EntityDisplayProcessor` (`id`, `label`, optional `deriver`).
- Manager `EntityDisplayProcessorManager` (autowired service, `entity_display_processor.services.yml`)
  extends `DefaultPluginManager`; alter hook `entity_display_processor`, discovery cache
  `entity_display_processor_info`. `getInstance(['id'=>…, 'settings'=>…])` → configured instance.
- Bundled plugin `custom_classes` (`Plugin/EntityDisplayProcessor/AddCustomClasses`) — appends
  space-separated classes to `#attributes['class']`; implements `PluginFormInterface`.
- Hooks are OOP (`#[Hook]`, no `.module` file): `Hook\EntityView::entityViewAlter()` applies the
  processor on render; `Hook\FieldUiForm` adds the selector to
  `entity_view_display_edit_form` and saves the choice in a custom submit handler.
- Form plumbing: `Element\Drilldown` (`entity_display_processor_drilldown`, `@internal`) = select +
  AJAX-swapped subform, plus callbacks `Callback\ElementAjax\AjaxReplaceCallback` and
  `Callback\IdToSubform\PluginIdToSubform`.
- Config: schema-only (`config/schema/entity_display_processor.schema.yml`); the processor id +
  settings live as a third-party setting `processor` on `core.entity_view_display.*.*.*`.
