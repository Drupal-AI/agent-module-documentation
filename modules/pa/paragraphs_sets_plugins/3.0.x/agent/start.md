<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Sets Plugins — agent index

Data-transform plugin system for Paragraphs Sets: a set's source data is processed (map, create
entities, nested entities) before paragraphs are built. Depends on `paragraphs_sets`. Developer-facing; no UI/permissions.

Quick facts:
- Plugin type: `@ParagraphsSetsProcess` annotation, dir `Plugin/paragraphs_sets/process`, base `ProcessPluginBase`/`ProcessPluginInterface`, manager service `paragraphs_sets_plugins.plugin_manager`.
- Built-ins: `Simple`, `CreateEntity`, `NestedEntities`.
- Wiring: `PluginTransformProcessor` (service `paragraphs_sets_plugins.plugin_transform_processor`) invoked from `hook_paragraphs_set_data_alter()`, transforming set data recursively.
